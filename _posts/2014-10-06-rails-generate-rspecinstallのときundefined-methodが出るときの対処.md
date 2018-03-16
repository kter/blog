---
id: 86
title: rails generate rspec:installのときundefined methodが出るときの対処
date: 2014-10-06T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=86
#permalink: /?p=86
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/rails-generate-rspecinstall%E3%81%AE%E3%81%A8%E3%81%8Dundefined-method%E3%81%8C%E5%87%BA%E3%82%8B%E3%81%A8%E3%81%8D%E3%81%AE%E5%AF%BE%E5%87%A6/'
rss_pi_source_md5:
  - 493ddb1873102e998d6fd21a09608454
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
<pre class="lang:default decode:true">$ rails generate rspec:install</pre>

を実行した時次のエラーが表示された(Rails4.0.5)。

<pre class="lang:default decode:true">&#047;home&#047;kter&#047;rails_projects&#047;sample_app&#047;config&#047;environments&#047;development.rb:1:in `': undefined method `configure' for # (NoMethodError)<br />
</pre>

&nbsp;

config&#047;environments&#047;development.rbの一行目を次のように変更するとうまく行った。

<pre class="lang:default decode:true ">SampleApp::Application.configure do</pre>

&nbsp;

Source: New feed