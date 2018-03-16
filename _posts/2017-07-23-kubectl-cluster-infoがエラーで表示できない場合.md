---
id: 451
title: kubectl cluster-infoがエラーで表示できない場合
date: 2017-07-23T22:47:50+00:00
author: kter
layout: post
#guid: https://kter.jp/?p=451
#permalink: /?p=451
categories:
  - GCP
  - Kubernetes
tags:
  - GCP
  - Kubernetes
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