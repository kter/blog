---
author: kter
categories:
- Kubernetes
date: "2017-11-12T16:29:47Z"
id: 558
image: /wp-content/uploads/2017/07/logo.png
tags:
- base64
- Kubernetes
title: Kubernetesのsecrets用のbase64の結果が2行になってしまうとき
---
Kubernetesのsecretsはbase64でエンコードした値を入力します。

<pre class="lang:default decode:true">$ echo 'secrets value' | base64
c2VjcmV0cyB2YWx1ZQo=</pre>

&nbsp;

この時エンコードする文字列が長いとエンコード結果が2行になってしまうときがあります。

<pre class="lang:default decode:true">$ echo 'long long long long long long long long long long secrets value' | base64
bG9uZyBsb25nIGxvbmcgbG9uZyBsb25nIGxvbmcgbG9uZyBsb25nIGxvbmcgbG9uZyBzZWNyZXRz
IHZhbHVlCg==</pre>

&nbsp;

2行の文字列をどうやってsecretsのymlファイルに書こうか少し迷いましたが、2行を単純に連結するだけで問題ありませんでした (知らなかった…)。

<pre class="lang:default decode:true">$ echo 'bG9uZyBsb25nIGxvbmcgbG9uZyBsb25nIGxvbmcgbG9uZyBsb25nIGxvbmcgbG9uZyBzZWNyZXRzIHZhbHVlCg==' | base64 -d
long long long long long long long long long long secrets value</pre>

&nbsp;

ちなみに<span class="lang:default decode:true crayon-inline">echo &#8216;hoge&#8217; | base64</span>してもいいですが、<span class="lang:default decode:true crayon-inline">base64 &lt;&lt;&lt; &#8216;hoge&#8217;</span> とした方が短くてスマートですね (こちらも知らなかった…)。

&nbsp;
