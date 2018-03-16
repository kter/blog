---
id: 68
title: MuninのMySQLプラグイン有効方法
date: 2015-01-15T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=68
#permalink: /?p=68
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/munin%E3%81%AEmysql%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E6%9C%89%E5%8A%B9%E6%96%B9%E6%B3%95/'
rss_pi_source_md5:
  - 596eec903ea19390076e48dcbbf836e9
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
初期状態ではMuninがMySQLのRootアカウントを使用してデータを収集しようとするので失敗する。
  
そのためMuninのデータ収集用MySQLアカウントを作成し、そのアカウントでデータ収集するよう設定する必要がある。

専用MySQLアカウント作成

<pre class="wrap:true lang:default decode:true">mysql&gt; CREATE USER munin@127.0.0.1 IDENTIFIED BY 'password';<br />
mysql&gt; GRANT SUPER,PROCESS ON *.* TO munin@127.0.0.1;<br />
mysql&gt; GRANT SELECT ON mysql.* TO munin@127.0.0.1;<br />
mysql&gt; FLUSH PRIVILEGES;</pre>

&nbsp;

専用MySQLアカウントを使用するようMuninを設定

&nbsp;

<pre class="wrap:true lang:default decode:true">vim &#047;etc&#047;munin&#047;plugin-conf.d&#047;mysql<br />
chmod 400 &#047;etc&#047;munin&#047;plugin-conf.d&#047;mysql<br />
cat &#047;etc&#047;munin&#047;plugin-conf.d&#047;mysql<br />
[mysql_*]<br />
env.mysqlconnection DBI:mysql:mysql;host=127.0.0.1;port=3306<br />
env.mysqluser munin<br />
env.mysqlpassword password</pre>

&nbsp;

設定の確認と反映

<pre class="wrap:true lang:default decode:true ">munin-node-configure --suggest<br />
munin-node-configure --shell 2&gt;&1 | grep mysql | &#047;bin&#047;bash<br />
service munin-node restart</pre>

&nbsp;

&nbsp;

参考URL:

http:&#047;&#047;alexcline.net&#047;2013&#047;07&#047;12&#047;setting-up-the-mysql_-plugin-in-munin&#047;

Source: New feed