---
id: 100
title: Ruby2.1系をソースからインストールしたときのOpenSSLのインストール
date: 2014-04-12T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=100
#permalink: /?p=100
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/ruby2-1%E7%B3%BB%E3%82%92%E3%82%BD%E3%83%BC%E3%82%B9%E3%81%8B%E3%82%89%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%97%E3%81%9F%E3%81%A8%E3%81%8D%E3%81%AEopenssl%E3%81%AE%E3%82%A4/'
rss_pi_source_md5:
  - 1e5c267084869b1d22bf5ed48855987d
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
Ruby2.1系をソースインストールした時、Railsなどをインストールしようとすると、OpenSSLのインストールを促されますが、OpenSSLパッケージをインストールするだけではいけません。

ソースのext&#047;opensslでextconf.rbを実行し、生成されたMakefileでmake installする必要がありますが、Makefileが間違えているので修正する必要があります。修正しないと次のエラーが出ます

> make: \*** \`ossl.o&#8217; に必要なターゲット \`&#047;thread_native.h&#8217; を make するルールがありません. &nbsp;中止.

よってRuby2.1.0でOpenSSLをインストールする際は次のようにする必要があります。

cd &#047;usr&#047;local&#047;src&#047;ruby2.1.0&#047;ext&#047;openssl
  
&#047;usr&#047;local&#047;bin&#047;ruby extconf.rb
  
cp -iv Makefile .__Makefile.bak
  
vim Makefile
  
diff Makefile .__Makefile.20140407-01
  
17d16
  
< top_srcdir = $(srcdir)&#047;..&#047;..
  
sudo make
  
sudo make install

Source: New feed