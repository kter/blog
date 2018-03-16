---
id: 577
title: "GKEでなるべく安くKubernetesクラスタを作成してPrometheus + Grafanaを使ってみる Part3 -SSL編-"
date: 2018-03-02T22:26:00+09:00
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
  - "Let's Encrypt"
  - "cert-manager"
---
タイトルの通りGKE (Google Kubernetes Engine)でKubernetesクラスタを作成して、その上でPrometheusとGrafanaを動かしてみます。

前回クラスタとそこにIngressを追加したので、今回はIngressでSSLを使えるようにします。

# はじめに

[cert-manager](https://github.com/jetstack/cert-manager)を使ってLet's Encryptから証明書を取得・設定していきます。

cert-managerで証明書を取得するためにはDNS認証かHTTP認証のいずれかを行う必要があります。

DNS認証はRoute53ではうまく動かなかったので、HTTP認証で行います。

# cert-managerのインストール

helmを使ってインストールします。

下記コマンドを実行してください。

```bash
git clone https://github.com/jetstack/cert-manager
cd cert-manager
helm install \
    --name cert-manager \
    --namespace=kube-system \
    contrib/charts/cert-manager \
    --set ingressShim.extraArgs='{--default-issuer-name=letsencrypt-prod,--default-issuer-kind=ClusterIssuer}'
```

# 設定

下記yamlをClusterIssuer.ymlとして保存してください。

※メールアドレスは自分のものを設定してください。

```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
  namespace: default
spec:
  acme:
    # The ACME server URL
    server: https://acme-v01.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: (メールアドレス)
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: letsencrypt-prod
    # Enable the HTTP-01 challenge provider
    http01: {}
```

下記yamlをcertificate.ymlとして保存してください。

各ドメインは自分のものを設定してください。

commonNameは証明書の通称として使われるものなので、(ドメイン1)を指定するといいと思います。

dnsNamesで指定したドメインは[SAN (Subject Alternative Name)](https://jp.globalsign.com/support/faq/516.html)として登録されます。

```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: (ハイフンつながりのドメインex: kter-jp)-tls
  namespace: default
spec:
  secretName: (ハイフンつながりのドメイン)-tls
  issuerRef:
    name: letsencrypt-prod
    kind: ClusterIssuer
  commonName: (ドメインex: kter.jp)
  dnsNames:
  - (ドメイン1)
  - (ドメイン2)
  - (ドメイン3)
  acme:
    config:
    - http01:
        ingressClass: nginx
      domains:
      - (ドメイン1)
    - http01:
        ingressClass: nginx
      domains:
      - (ドメイン2)
    - http01:
        ingressClass: nginx
      domains:
      - (ドメイン3)
```

設定を反映します。

下記コマンドを実行してください。

```bash
kubectl apply -f ClusterIssuer.yml
kubectl apply -f certificate.yml
```

進捗は下記コマンドで確認出来ます。

```bash

kubectl describe certificate
```

# 確認

各ドメインにhttpsでアクセスして、証明書が正しく設定されるか確認します。

