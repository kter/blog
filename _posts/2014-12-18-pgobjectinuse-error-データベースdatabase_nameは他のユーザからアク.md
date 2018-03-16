---
id: 70
title: 'PG::ObjectInUse: ERROR: データベース&quot;database_name&quot;は他のユーザからアクセスされています'
date: 2014-12-18T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=70
#permalink: /?p=70
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/pgobjectinuse-error-%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9database_name%E3%81%AF%E4%BB%96%E3%81%AE%E3%83%A6%E3%83%BC%E3%82%B6%E3%81%8B%E3%82%89%E3%82%A2%E3%82%AF%E3%82%BB/'
rss_pi_source_md5:
  - 944d0d6569721fbe276ffbff97bea240
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
Postgresqlを使用している時、データベースの削除などをした時下記のようなエラーが表示された時の対処

<pre class="lang:default decode:true ">PG::ObjectInUse: ERROR: データベース"database_name"は他のユーザからアクセスされています<br />
DETAIL: 他にこのデータベースを使っている 1 個のセッションがあります。</pre>

エラー文の通り操作しようとしているデータベースにアクセスしているユーザがいるためなので、このユーザを強制的に追い出します。

まずアクセスしているユーザを調べます。

&#8220;\`
  
SELECT * FROM pg\_stat\_activity;
  
&#8220;\`

該当ユーザのprocidとusernameをメモし、追い出します

&#8220;\`
  
SELECT pg\_terminate\_backend(procpid) FROM pg\_stat\_activity WHERE usename = &#8216;usename&#8217;;
  
&#8220;\`

&nbsp;

以上

Source: New feed