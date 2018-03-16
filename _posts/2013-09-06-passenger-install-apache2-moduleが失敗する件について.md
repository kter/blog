---
id: 120
title: passenger-install-apache2-moduleが失敗する件について
date: 2013-09-06T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=120
#permalink: /?p=120
rss_pi_source_url:
  - http://blog.kter.jp/blog/install-failed-redmine/
rss_pi_source_md5:
  - 9c3547b2ceb74cb4b313ce56f91f9b24
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
Passengerをインストールするとき、passenger-install-apache2-moduleを実行しますが、Apacheをソースインストールしていたりすると、次のようなエラーが出てうまくインストールできません。

<div class="highlight">
  <pre><code class="language-">Checking for required software...

* GNU C++ compiler... found at /usr/bin/g++
* Curl development headers with SSL support... not found
* OpenSSL development headers... found
* Zlib development headers... found
* Ruby development headers... found
* OpenSSL support for Ruby... found
* RubyGems... found
* Rake... found at /usr/bin/rake
* rack... found
* Apache 2... not found
* Apache 2 development headers... not found
* Apache Portable Runtime (APR) development headers... not found
* Apache Portable Runtime Utility (APU) development headers... not found
</code></pre>
</div>

上記例では
  
`<br />
* Curl development headers with SSL support... not found<br />
` 
  
とあるので、yumかなにかでcurl-develをインストールします(yum install curl-devel)。

Apache関係はソースインストールしたせいで、パスを見失っているだけなので、下記コマンドで場所を教えてあげます

<div class="highlight">
  <pre><code class="language-">passenger-install-apache2-module --apxs2-path /usr/local/apache2/bin/apxs --apr-config-path /usr/local/apache2/bin/apr-1-config
</code></pre>
</div>

Source: New feed