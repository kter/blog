---
author: kter
categories:
- 未分類
date: "2015-02-20T00:00:00Z"
id: 67
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- d52efc38ed6251fc0c58641d5210d5fb
rss_pi_source_url:
- http://blog.kter.jp/blog/vagrant-plugin-install-vagrant-aws%E3%81%A7%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%AB%E5%A4%B1%E6%95%97%E3%81%99%E3%82%8B%E3%81%A8%E3%81%8D/
title: vagrant plugin install vagrant-awsでインストールに失敗するとき
---
vagrant plugin install vagrant-awsdでインストールに失敗するとき

-vvvオプションを付けるとnokogiriのインストールで失敗しているのが分かった。

nokogiri単体でのインストールは上手く行っていた。

最終的にはNOKOGIRI\_USE\_SYSTEM_LIBRARIES=1をつけてvagrant installすることで上手く行った。

Source: New feed