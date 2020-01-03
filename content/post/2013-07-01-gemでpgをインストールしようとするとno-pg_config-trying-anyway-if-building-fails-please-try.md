---
author: kter
categories:
- 未分類
date: "2013-07-01T00:00:00Z"
id: 124
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- ad5974b62d94939f087e159edd86df95
rss_pi_source_url:
- http://blog.kter.jp/blog/install-error-on-pg-gem/
title: gemでpgをインストールしようとするとNo pg_config&#8230; trying anyway. If building fails, please
  try again withとエラーが表示される
---
gemでpgをインストールしようとするとNo pg_config&#8230; trying anyway. If building fails, please try again withとエラーが表示される

<div class="highlight">
  <pre><code class="language-">% sudo gem install pg -v=0.13.2
Building native extensions. This could take a while...

ERROR: Error installing pg:
ERROR: Failed to build gem native extension.

/usr/local/bin/ruby extconf.rb
checking for pg_config... no
No pg_config... trying anyway. If building fails, please try again with
--with-pg-config=/path/to/pg_config
checking for libpq-fe.h... no
Can't find the 'libpq-fe.h header
*** extconf.rb failed ***
Could not create Makefile due to some reason, probably lack of
necessary libraries and/or headers. Check the mkmf.log file for more
details. You may need configuration options.

Provided configuration options:
--with-opt-dir
--without-opt-dir
--with-opt-include
--without-opt-include=${opt-dir}/include
--with-opt-lib
--without-opt-lib=${opt-dir}/lib
--with-make-prog
--without-make-prog
--srcdir=.
--curdir
--ruby=/usr/local/bin/ruby
--with-pg
--without-pg
--with-pg-dir
--without-pg-dir
--with-pg-include
--without-pg-include=${pg-dir}/include
--with-pg-lib
--without-pg-lib=${pg-dir}/lib
--with-pg-config
--without-pg-config
--with-pg_config
--without-pg_config
Gem files will remain installed in /usr/local/lib/ruby/gems/1.8/gems/pg-0.13.2 for inspection.
Results logged to /usr/local/lib/ruby/gems/1.8/gems/pg-0.13.2/ext/gem_make.out
</code></pre>
</div>

こんな感じのエラーが表示された場合、

<div class="highlight">
  <pre><code class="language-">sudo gem install pg -v=0.13.2 -- --with-pg-config=/usr/local/pgsql/bin/pg_config
</code></pre>
</div>

などとpg_configのパスを指定すればおｋ

Source: New feed