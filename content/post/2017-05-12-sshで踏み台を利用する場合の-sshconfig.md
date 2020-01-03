---
author: kter
categories:
- Linux
date: "2017-05-12T18:54:38Z"
id: 332
tags:
- Linux
- SSH
title: SSHで踏み台を利用する場合の.ssh/config
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