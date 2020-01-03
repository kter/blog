---
author: kter
categories:
- 未分類
date: "2015-08-25T00:00:00Z"
id: 59
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- bd01d28898d0b05b7626ffa0eea0d0ef
rss_pi_source_url:
- http://blog.kter.jp/blog/x509_check_private_keykey-values-mismatch/
title: NginxでSSL証明書を設定するとX509_check_private_key:key values mismatchが表示される件について
---
NginxでSSLを使用とした時、次のようなエラーが発生した。

<pre class="wrap:true lang:default decode:true "># nginx -t<br />
nginx: [emerg] SSL_CTX_use_PrivateKey_file("秘密鍵") failed (SSL: error:0B080074:x509 certificate routines:X509_check_private_key:key values mismatch)<br />
nginx: configuration file &#047;etc&#047;nginx&#047;nginx.conf test failed</pre>

&nbsp;

検索すると証明書が間違っているとか出てきますが、私は中間証明書のインストール位置を間違えていました。

中間証明書は証明書の末尾に追記しましょう。

Source: New feed