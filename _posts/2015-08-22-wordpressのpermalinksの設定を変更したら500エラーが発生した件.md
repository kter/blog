---
id: 61
title: WordPressのpermalinksの設定を変更したら500エラーが発生した件
date: 2015-08-22T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=61
#permalink: /?p=61
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/wordpress%E3%81%AEpermalinks%E3%81%AE%E8%A8%AD%E5%AE%9A%E3%82%92%E5%A4%89%E6%9B%B4%E3%81%97%E3%81%9F%E3%82%89500%E3%82%A8%E3%83%A9%E3%83%BC%E3%81%8C%E7%99%BA%E7%94%9F%E3%81%97%E3%81%9F%E4%BB%B6/'
rss_pi_source_md5:
  - 43714f99d301fe95118b626811c5d5fe
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
WordPressのpermalinksの設定を変更したら500 Internal Server Errorが発生し、一切のアクセスができなくなった。

問題はApacheの設定で、.htaccessファイルの設定が有効になっていなかったせいでした。

具体的にはAllowOverrideの設定を

<pre class="lang:default decode:true ">AllowOverride All</pre>

に変更したらページが表示されるようになりました。

&nbsp;

参考

<a href="http:&#047;&#047;httpd.apache.org&#047;docs&#047;2.2&#047;ja&#047;mod&#047;core.html#allowoverride" target="_blank">core &#8211; Apache HTTP サーバ バージョン 2.2</a>

&nbsp;

Source: New feed