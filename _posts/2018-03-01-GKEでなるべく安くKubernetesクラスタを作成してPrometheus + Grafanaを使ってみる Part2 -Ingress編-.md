---
id: 576
title: "GKEでなるべく安くKubernetesクラスタを作成してPrometheus + Grafanaを使ってみる Part2 -Ingress編"
date: 2018-03-01T23:50:00+09:00
author: kter
layout: post
image: 
categories:
  - Kubernetes
tags:
  - GKE
  - Kubernetes
  - Prometheus
  - Grafana
  - cert-manager
---
タイトルの通りGKE (Google Kubernetes Engine)でKubernetesクラスタを作成して、その上でPrometheusとGrafanaを動かしてみます。

前回クラスタを作成したので今回はIngressを追加します。

Ingressを追加することで、クラスタ内のサービスにインターネットからアクセスできるようになります。

# はじめに

Ingressは普通にGKEで作成すると、Ingress ControllerがGCPのロードバランサーを作成します。

しかしこれが高い…。月額18ドルも掛かります。

そこでGCPのロードバランサーの代わりにnginx-ingressというNGINXを使います。

こちらを一番小さいf1-microのノードで動かせば4.28ドルで済みます。

しかもf1-microはAlways Freeの条件であるus-east1, us-west1, us-central1のいずれかで動かせばタダで動かせます。


なので今回はロードバランサーを使わず、nginx-ingressを使うことにします。

# 前提作業

前回の記事のGKEでなるべく安くKubernetesクラスタを作成してPrometheus + Grafanaを使ってみる Part1 -クラスタ作成編-の手順でクラスタを作成してあることを前提とします。


また疎通確認にドメインを使用しますので、用意してください。

~~ドメインを持っていない方はnip.ioとか使うといいと思います。知らんけど。~~

# Ingress Controller用ノードを作成

前回作成したクラスタのノードはプリエンプティブノードのため一定時間で削除されます。

nginx-ingressでは静的グローバルIPをノードに割り当てる必要があるため、削除されないノードを別途作成します。

具体的にはIngress Controllerを動かすためのノードプールを作成します。


1. クラスタ編集画面を開く
2. "ノードプールを追加"ボタンを選択
3. 名前にload-balancerと入力
4. マシンタイプにmicro (f1-micro)を選択
5. ノードあたりのブートディスク サイズに10GBと入力

# Ingress Controller用ノードの設定

下記コマンドを実行します。

```bash
export CLUSTER_NAME=クラスタ名
export ZONE=us-west1-b
export REGION=us-west1
# kubectlを使えるようにする
gcloud container clusters get-credentials $CLUSTER_NAME --zone $ZONE
# 静的グローバルIPアドレスを確保
gcloud compute addresses create $CLUSTER_NAME-ip --region $REGION
# 静的グローバルIPアドレスを取得
export LB_ADDRESS_IP=$(gcloud compute addresses list | grep $CLUSTER_NAME-ip | awk '{print $3}')
# nginx-ingressで使うノード名を取得
export LB_INSTANCE_NAME=$(kubectl describe nodes | grep Name: | tail -n1 | awk '{print $2}')
# nginx-ingressしか動かないようにする (リソースの確保のため)
kubectl taint nodes $LB_INSTANCE_NAME role=nginx-ingress-controller:NoSchedule
# 静的グローバルIPアドレスをノードに紐付ける
export LB_INSTANCE_NAT=external-nat
gcloud compute instances delete-access-config $LB_INSTANCE_NAME --access-config-name "$LB_INSTANCE_NAT" --zone $ZONE
gcloud compute instances add-access-config $LB_INSTANCE_NAME --access-config-name "$LB_INSTANCE_NAT" --address $LB_ADDRESS_IP --zone $ZONE
# ラベルの設定
kubectl label nodes $LB_INSTANCE_NAME role=load-balancer
# タグの設定 (これで80と443に外部からアクセスできるようになる)
gcloud compute instances add-tags $LB_INSTANCE_NAME --tags http-server,https-server --zone $ZONE
```

# helmの導入

helmとはKubernetesのパッケージマネージャーです。

nginx-ingressはhelmでも提供されているので、nginx-ingressの導入の前にhelmをまず導入します。

## helmをインストール

下記コマンドを実行します。

```bash
# ダウンロード先: https://github.com/kubernetes/helm/releases
curl -O https://storage.googleapis.com/kubernetes-helm/helm-v2.8.1-linux-amd64.tar.gz
tar -zxvf helm-v2.8.1-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
```

## クラスタにhelmを導入

下記コマンドを実行します。

```bash
helm init --service-account tiller
echo "apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
" | kubectl apply -f -
```

# nginx-ingressの導入

一応ドメインとそれに紐づくサービスは下記の通りということで話を進めます。適宜読み替えてください。

※AレコードとしてLB_ADDRESS_IPのIPを登録しておいてください。

| ドメイン | サービス名 | 用途 |
| ------ | ------ | ------ |
| (ドメイン1) | nginx | サンプルアプリケーション |
| (ドメイン2) | prometheus-prometheus |Prometheus用　|
| (ドメイン3) | grafana-grafana | Grafana用 |


## nginx-ingressの導入

helmでnginx-ingressを導入します。


設定をvalues.yamlという名前で保存してからnginx-ingressをインストールします。

下記コマンドを実行してください。

```bash
mkdir nginx-ingress && cd $_
curl -O https://raw.githubusercontent.com/kter/personal-project/1.1/nginx-ingress/values.yaml
helm install stable/nginx-ingress --name nginx-ingress -f values.yaml
```

## Ingressの設定作成

Ingressの設定をyamlで記載します。

nginx-ingress.ymlという名前で保存してください。

```yaml

apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: nginx
  annotations:
    kubernetes.io/ingress.class: "nginx"
    kubernetes.io/tls-acme: "true"
spec:
  tls:
  - secretName: kubernetes-ingress-tls
    hosts:
      - (ドメイン1)
      - (ドメイン2)
      - (ドメイン3)
  rules:
  - host: (ドメイン1)
    http:
      paths:
      - path: /
        backend:
          serviceName: nginx
          servicePort: 80
      - path: /*
        backend:
          serviceName: nginx
          servicePort: 80
  - host: (ドメイン2)
    http:
      paths:
      - path: /
        backend:
          serviceName: prometheus-prometheus-server
          servicePort: 80
      - path: /*
        backend:
          serviceName: prometheus-prometheus-server
          servicePort: 80
  - host: (ドメイン3)
    http:
      paths:
      - path: /
        backend:
          serviceName: grafana-grafana
          servicePort: 80
      - path: /*
        backend:
          serviceName: grafana-grafana
          servicePort: 80
```

## Ingressの設定反映

下記コマンドを実行します。

```bash
kubectl apply -f nginx-ingress.yml
```

# サンプルアプリケーションをデプロイ

下記yamlをnginx-deployment.ymlとして保存してください。

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: nginx
  labels:
    name: nginx
spec:
  replicas: 1
  template:
    metadata:
      labels:
        name: nginx
    spec:
      containers:
        - name: nginx
          image: nginx
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: 10m
```

下記yamlをnginx-service.ymlとして保存してください。

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
    name: nginx
spec:
  ports:
    - port: 80
      targetPort: 80
      protocol: TCP
      name: nginx
  type: NodePort
  selector:
    name: nginx
```

下記コマンドを実行してnginxをデプロイします。

```bash
kubectl apply -f blog-deployment.yml
kubectl apply -f blog-service.yml
```

# 疎通確認

(ドメイン1)にアクセスし、NGINXの画面が表示されれば成功です。

他のドメインについては、まだデプロイを行っていないのでdefault-backendの表示がされるはずです。

# 終わりに

今回は作成したクラスタのサービスにアクセスするためのIngressを作成しました。

次回はLet's Encryptによるhttpsが使えるように設定を行う予定です。

