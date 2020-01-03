---
author: kter
categories:
- 未分類
date: "2013-12-05T00:00:00Z"
id: 108
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- 784ea6ee291aded6a766911c1eb5b900
rss_pi_source_url:
- http://blog.kter.jp/blog/mysqld_safe-does-not-start/
title: 'File &#039;./mysql-bin.index&#039; not found (Errcode: 13)'
---
mysqlをソースからインストールして、mysqld_safeなどで起動しようとした時、次のエラーが発生

<div class="highlight">
  <pre><code class="language-">File './mysql-bin.index' not found (Errcode: 13)
</code></pre>
</div>

インストールが終わった後にmysql_install_dbでデータベースを初期化?したのだが、オプションを指定しないといけなかったらしい。多分datadirの指定が必要だったんだな。

というわけでインストール先ディレクトリのオーナーとグループを mysqlに

<div class="highlight">
  <pre><code class="language-">$ sudo chown mysql.mysql /usr/local/mysql
</code></pre>
</div>

mysql_install_dbにオプションを付けて次のように実行

<div class="highlight">
  <pre><code class="language-">$ sudo /usr/local/mysql/bin/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data
</code></pre>
</div>

Source: New feed