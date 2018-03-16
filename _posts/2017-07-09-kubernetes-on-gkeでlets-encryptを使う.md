---
id: 398
title: 'kubernetes on GKEでLet&#8217;s Encryptを使う'
date: 2017-07-09T13:05:28+00:00
author: kter
layout: post
#guid: https://blog.kter.jp/?p=398
#permalink: /?p=398
image: /wp-content/uploads/2017/07/logo.png
categories:
  - Docker
  - GCP
  - Kubernetes
tags:
  - Docker
  - GCP
  - GKE
  - Kubernetes
  - "Let's Encrypt"
  - SSL
---
kubernetes on GKEでLet&#8217;s Encryptを使ったときのメモ

kubenetesでLet&#8217;s Encryptを使うのに、[kube-lego](https://github.com/jetstack/kube-lego)を使用します。

kube-legoではGCEのロードバランサーとNginx Ingress Controllerが使えるようですが、今回はロードバランサーを使う手順でやります（このあたりよく分かっていない…)。
  
&nbsp;

7月13日追記
  
GCEのロードバランサーを使わない手順ができました。
  
https://github.com/kter/kube-study/tree/master/ingress/nginx-tls

### kube-legoのダウンロード

<pre class="lang:default decode:true " >git clone https://github.com/jetstack/kube-lego.git
vim kube-lego/examples/gce/lego/configmap.yaml</pre>

(メールアドレスを自分のものに編集)

&nbsp;

### IPの払い出し

IPを払い出す

<pre class="lang:default decode:true " >gcloud compute addresses create "IPの識別名" --global</pre>

払い出したIPにドメインを紐付けておく。

&nbsp;

### ファイルの作成

kube-legoで使用するnginx-ingress.ymlを作成する。
  
SSL化したいサービスを下記web-service.ymlとした場合、nginx-ingress.ymlは次のようになるので適当な場所に作成しておく。





&nbsp;

### kube-legoを作成する

<pre class="lang:default decode:true " >cd kube-lego/examples/gce
kubectl apply -f lego/00-namespace.yaml
kubectl apply -f lego/configmap.yaml
kubectl apply -f lego/deployment.yaml
kubectl create -f /path/to/nginx-ingress.yml</pre>

設定が反映されるまで、十数分掛かるので暫く待つ。

### 備考

作成されるものはkube-legoというnamespaceとなっているため、kubectlを実行する際は`--namespace kube-lego`が必要になる。