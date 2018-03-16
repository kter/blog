---
id: 453
title: ImageMagicのコマンドで画像サイズを調べる方法
date: 2017-07-24T15:33:16+00:00
author: kter
layout: post
#guid: https://kter.jp/?p=453
#permalink: /?p=453
categories:
  - Linux
tags:
  - ImageMagic
  - Linux
---
identifyコマンドを使う。具体的には次の通り。

<pre class="lang:default decode:true ">% identify -format "%w x %h" 画像ファイル名
550 x 850
</pre>

formatオプションで表示内容を制御できる。