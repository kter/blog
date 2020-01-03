---
author: kter
categories:
- Docker
- GCP
- Kubernetes
date: "2017-07-19T16:50:32Z"
id: 435
tags:
- Docker
- GCP
- GKE
- Kubernetes
- NFS
title: KubernetesでNFSを使う
---
KurbernetesのPod / Node間でファイルを共有するために、NFSを使ってみる。
  
ググったり公式のリポジトリを参考にしたけどうまくいかなかったのでメモ。

&nbsp;

#### おおまかな手順

1. Compute Engineでディスクを用意
  
2. NFSコンテナの用意
  
3. コンテナからNFSを利用

&nbsp;

#### 手順

&nbsp;

##### Compute Engineでディスクを用意

コンソールかCLI等から普通に作成。

&nbsp;

##### 

##### NFSコンテナの用意

下記2ファイルを用意してkubectl createする。

<pre class="lang:default decode:true " title="nfs-deployment.yml">apiVersion: v1
kind: ReplicationController
metadata:
  name: nfs-server
spec:
  replicas: 1
  selector:
    role: nfs-server
  template:
    metadata:
      labels:
        role: nfs-server
    spec:
      containers:
      - name: nfs-server
        image: gcr.io/google-samples/nfs-server:1.1
        ports:
          - name: nfs
            containerPort: 2049
          - name: mountd
            containerPort: 20048
          - name: rpcbind
            containerPort: 111
        securityContext:
          privileged: true
        volumeMounts:
          - mountPath: /exports
            name: nfs-disk
      volumes:
        - name: nfs-disk
          gcePersistentDisk:
            # ディスク名を入力
            pdName: DISK NAME
            fsType: ext4</pre>

<pre class="lang:default decode:true " title="nfs-service.yml">kind: Service
apiVersion: v1
metadata:
  name: nfs-server
spec:
  ports:
    - name: nfs
      port: 2049
    - name: mountd
      port: 20048
    - name: rpcbind
      port: 111
  selector:
    role: nfs-server</pre>

&nbsp;

##### コンテナからNFSを利用

利用したいコンテナのDeploymentで、spec.volumesとspec.containers.volumeMountsを設定する。

<pre class="lang:default decode:true">volumes:
        - name: nfs
          nfs:
            # NFSサーバのIPアドレス
            server: NFS SERVER IP
            path: "/exports"</pre>

<pre class="lang:default decode:true">volumeMounts:
            - name: nfs
              # マウント先
              mountPath: "MOUNT PATH"</pre>

例

<pre class="lang:default decode:true">apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: blog
  labels:
    name: blog
spec:
  replicas: 1
  template:
    metadata:
      labels:
        name: blog
    spec:
      nodeSelector:
        cloud.google.com/gke-nodepool: default-pool
      containers:
        - name: blog
          image: wordpress:4.8.0-php7.1-apache
          ports:
            - containerPort: 80
          env:
            - name: WORDPRESS_DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: wordpress_db_password
            - name: WORDPRESS_DB_USER
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: wordpress_db_user
            - name: WORDPRESS_DB_HOST
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: wordpress_db_host
          volumeMounts:
            - name: nfs
              mountPath: "/var/www/html"
      volumes:
        - name: nfs
          nfs:
            server: 10.11.249.76
            path: "/exports"</pre>

&nbsp;

&nbsp;

肝心のNode間でデータの読み書きができるのかは未検証…