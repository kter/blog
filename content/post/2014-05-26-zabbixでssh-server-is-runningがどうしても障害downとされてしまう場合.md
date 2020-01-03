---
author: kter
categories:
- 未分類
date: "2014-05-26T00:00:00Z"
id: 94
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- 148cea4768cde0b0ecdf0ae75eb5bdb2
rss_pi_source_url:
- http://blog.kter.jp/blog/zabbix%E3%81%A7ssh-server-is-running%E3%81%8C%E3%81%A9%E3%81%86%E3%81%97%E3%81%A6%E3%82%82%E9%9A%9C%E5%AE%B3%E3%81%A8%E3%81%95%E3%82%8C%E3%81%A6%E3%81%97%E3%81%BE%E3%81%86%E5%A0%B4%E5%90%88%E3%81%AE/
title: ZabbixでSSH server is runningがどうしても障害(Down)とされてしまう場合の対処
---
Zabbixを使っているとき、SSH server is runnningが障害と見なされる場合があります。

そもそもこのアイテムはどう判定しているのかというと、サーバからエージェントのアクセスでは無く、エージェントから自身のSSHサーバにアクセスして判定をしています。

ということでssh localhostと打って確認してみましょう。

&nbsp;

&hellip;どうでしょうか。ssh\_exchange\_identificationと表示されたなら、次に&#047;etc&#047;hosts.allowを確認してみてください。

おそらく何かかしらのルールが書いてあるはずなので、sshd : localhostなどと書いておきましょう。

これでいけるはずです

Source: New feed