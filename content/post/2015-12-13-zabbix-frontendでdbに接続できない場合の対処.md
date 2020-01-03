---
author: kter
categories:
- 未分類
date: "2015-12-13T00:00:00Z"
id: 55
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- 25e09be2d537cd361d8d27d39fe541fe
rss_pi_source_url:
- http://blog.kter.jp/blog/zabbix-frontend-cant-connect-to-db/
title: Zabbix FrontendでDBに接続できない場合の対処
---
zabbix-serverはDBに繋がるのにweb frontはDBがタイムアウトになる場合

RPMでインストールした場合、フロントエンドのDB設定は/usr/share/zabbix/conf/zabbix.conf.phpではなく/etc/zabbix/web/zabbix.conf.phpを参照するため、このファイルを変更する必要があります。

Source: New feed