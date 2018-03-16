---
id: 92
title: メール送信でRelay access denied
date: 2014-06-12T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=92
#permalink: /?p=92
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/%E3%83%A1%E3%83%BC%E3%83%AB%E9%80%81%E4%BF%A1%E3%81%A7relay-access-denied/'
rss_pi_source_md5:
  - 7ab01243c32e340cdd8ffadf1e2b6238
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
Postfixでメールを送信しようとしたところ、rcptでRelay access deniedと言われてしまいました。

<pre class="lang:default decode:true">$ telnet localhost 25<br />
Trying ::1...<br />
Connected to localhost.<br />
Escape character is '^]'.<br />
220 domain.tld ESMTP Postfix<br />
helo localhost<br />
250&nbsp;domain.tld<br />
mail from:<br />
250 2.1.0 Ok<br />
rcpt to:<br />
554 5.7.1 : Relay access denied</pre>

このとき&#047;var&#047;log&#047;maillogを見ると次のようにありました。

<pre class="lang:default decode:true">NOQUEUE: reject: RCPT from localhost[::1]: 554 5.7.1 : Relay access denied; from= to= proto=SMTP helo=</pre>

よくみると、RCPT from localhost[::1]と、IPv6のアドレスでアクセスしていることが分かります。 main.cfのinet_protocolsを次のようにしてIPv4を使うようにすればOKです

<pre class="lang:default decode:true ">inet_protocols = ipv4<br />
</pre>

<span style="line-height: 1.714285714;font-size: 1rem">腑に落ちませんがこれで解消です</span>

Source: New feed