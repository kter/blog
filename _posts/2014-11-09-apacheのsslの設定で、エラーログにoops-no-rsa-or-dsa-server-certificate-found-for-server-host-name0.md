---
id: 81
title: 'ApacheのSSLの設定で、エラーログにOops, no RSA or DSA server certificate found for &#039;server.host.name:0&#039;?!と表示された時の対処'
date: 2014-11-09T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=81
#permalink: /?p=81
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/apache%E3%81%AEssl%E3%81%AE%E8%A8%AD%E5%AE%9A%E3%81%A7-%E3%82%A8%E3%83%A9%E3%83%BC%E3%83%AD%E3%82%B0%E3%81%ABoops-no-rsa-or-dsa-server-certificate-found-for-server-host-name0%E3%81%A8/'
rss_pi_source_md5:
  - 254e52c81a176753b00b61a1b1538260
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
ApacheのSSLの設定で、エラーログにOops, no RSA or DSA server certificate found for &#8216;server.host.name:0&#8217;?!と表示された時の対処

設定していたVirtualHostにSSLEngine onを追記したらうまくいきました。

Source: New feed