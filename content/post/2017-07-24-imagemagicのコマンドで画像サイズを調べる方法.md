---
author: kter
categories:
- Linux
date: "2017-07-24T15:33:16Z"
id: 453
tags:
- ImageMagic
- Linux
title: ImageMagicのコマンドで画像サイズを調べる方法
---
identifyコマンドを使う。具体的には次の通り。

<pre class="lang:default decode:true ">% identify -format "%w x %h" 画像ファイル名
550 x 850
</pre>

formatオプションで表示内容を制御できる。