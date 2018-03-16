---
id: 89
title: '[warn] _default_ VirtualHost overlap on port 80, the first has precedenceと表示される時の対処'
date: 2014-07-07T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=89
#permalink: /?p=89
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/warn-_default_-virtualhost-overlap-on-port-80-the-first-has-precedence%E3%81%A8%E8%A1%A8%E7%A4%BA%E3%81%95%E3%82%8C%E3%82%8B%E6%99%82%E3%81%AE%E5%AF%BE%E5%87%A6/'
rss_pi_source_md5:
  - f35b0d71d3ad839c0edc09089e53af11
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
バーチャルホストを使用するときapachectl -tなどで、[warn] \_default\_ VirtualHost overlap on port 80, the first has precedenceと表示される時の対処

httpd.confに次の行を書きましょう。デフォルトではコメントアウトになっているはずです。

> NameVirtualHost *:80

Source: New feed