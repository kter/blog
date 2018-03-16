---
id: 332
title: SSHで踏み台を利用する場合の.ssh/config
date: 2017-05-12T18:54:38+00:00
author: kter
layout: post
#guid: https://blog.kter.jp/?p=332
#permalink: /?p=332
categories:
  - Linux
tags:
  - Linux
  - SSH
---
SSHでサーバにログインする時、踏み台を経由する場合があります。
  
そんな時の.ssh/configの設定です。

下記設定であれば、
  
`ssh (SSH先識別名)`
  
で踏み台サーバを経由して目的のサーバにログインできます。

`<br />
# SSH先<br />
Host (SSH先識別名)<br />
  Hostname IPアドレス<br />
  ProxyCommand ssh -W %h:%p SSH踏み台識別名</p>
<p># SSH踏み台<br />
Host (SSH踏み台識別名)<br />
  HostName IPアドレス<br />
`