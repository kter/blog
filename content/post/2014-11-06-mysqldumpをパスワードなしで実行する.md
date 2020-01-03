---
author: kter
categories:
- 未分類
date: "2014-11-06T00:00:00Z"
id: 84
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- 1d5ec83d3b5e78467b816935f1a5c8b5
rss_pi_source_url:
- http://blog.kter.jp/blog/mysqldump%E3%82%92%E3%83%91%E3%82%B9%E3%83%AF%E3%83%BC%E3%83%89%E3%81%AA%E3%81%97%E3%81%A7%E5%AE%9F%E8%A1%8C%E3%81%99%E3%82%8B/
title: mysqldumpをパスワードなしで実行する
---
cronなどでmysqldumpを実行したいけどパスワードをそのまま書くのはちょっと&hellip;という場合はパスワードをファイルに書き出し、それを読みこませることでパスワードの指定なしに実行できます。

実行ユーザのホームディレクトリに.my.cnfという名前で下記3行を書きましょう。

<pre class="lang:default decode:true" title=".my.cnf">[mysqldump]<br />
user=実行ユーザ<br />
password=pass</pre>

これでOK

Source: New feed