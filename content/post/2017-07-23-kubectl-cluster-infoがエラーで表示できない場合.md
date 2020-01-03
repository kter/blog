---
author: kter
categories:
- GCP
- Kubernetes
date: "2017-07-23T22:47:50Z"
id: 451
tags:
- GCP
- Kubernetes
title: kubectl cluster-infoがエラーで表示できない場合
---
kubectl cluster-infoが下記エラーで表示できない場合の対応

&nbsp;

<p class="p1">
  error: google: could not find default credentials. See <a href="https://developers.google.com/accounts/docs/application-default-credentials"><span class="s1">https://developers.google.com/accounts/docs/application-default-credentials</span></a> for more information.
</p>

&nbsp;

下記コマンドを実行してみる。

<pre class="lang:default decode:true ">gcloud auth application-default login</pre>

&nbsp;