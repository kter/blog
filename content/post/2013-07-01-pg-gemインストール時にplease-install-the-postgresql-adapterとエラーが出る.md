---
author: kter
categories:
- 未分類
date: "2013-07-01T00:00:00Z"
id: 125
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- 5970ca57b60c59c3be480498c06f191a
rss_pi_source_url:
- http://blog.kter.jp/blog/install-error-on-pg-gem2/
title: pg gemインストール時にPlease install the postgresql adapterとエラーが出る
---
<div class="highlight">
  <pre><code class="language-">Please install the postgresql adapter: `gem install activerecord-postgresql-adapter` (libpq.so.5: cannot open shared object file: No such file or directory - /usr/local/lib/ruby/gems/1.8/gems/pg-0.13.2/lib/pg_ext.so)


このlibpq.so.5は/usr/local/pgsql/libに入っているので

/usr/lib/にシンボリックリンクを貼ってみる

sudo ln -s /usr/local/pgsql/lib/libpq.so.5 /usr/lib

これでおｋ
</code></pre>
</div>

Source: New feed