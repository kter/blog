---
author: kter
categories:
- 未分類
date: "2013-09-06T00:00:00Z"
id: 119
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- 2258a0bca0d021eb9ffbfbdcd5adf0bc
rss_pi_source_url:
- http://blog.kter.jp/blog/failed-install-mod_python/
title: 'mod_pythonをインストールしようとした時checking for Py_NewInterpreter in -lpython2.6&#8230;
  no configure: error: Can not link to pythonとエラーが出る'
---
mod_pythonを入れようとして、

<div class="highlight">
  <pre><code class="language-">$ ./configure --with-apxs=/usr/local/apache2/bin/apxs
checking for gcc... gcc
checking for C compiler default output file name... a.out
(略)
checking for Py_NewInterpreter in -lpython2.6... no
configure: error: Can not link to python
</code></pre>
</div>

と表示された場合。

<div class="highlight">
  <pre><code class="language-">yum install python-devel
</code></pre>
</div>

で解決

Source: New feed