---
id: 123
title: 'ERROR: While executing gem &#8230; (NoMethodError) undefined method `map&#039; for Gem::Specification:Class'
date: 2013-07-03T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=123
#permalink: /?p=123
rss_pi_source_url:
  - http://blog.kter.jp/blog/nomethoderror-when-installing-gem/
rss_pi_source_md5:
  - 3806f2ada3a4e21d937c0149ba35c9ed
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
<div class="highlight">
  <pre><code class="language-">% sudo gem install hogehoge_gem
Successfully installed hogehoge_gem
1 gem installed
Installing ri documentation for hogehoge_gem...
ERROR: While executing gem ... (NoMethodError)
undefined method `map' for Gem::Specification:Class
</code></pre>
</div>

とか表示されるとき

~/.gemrcに

`gem: --no-rdoc --no-ri`

を追加すればよろし。

`sudo gem install hogehoge_gem --no-rdoc --no-ri`
   
でも同じことだと思う(未確認)

参考
   
<http://stackoverflow.com/questions/7535737/using-no-rdoc-and-no-ri-with-bundler>

Source: New feed