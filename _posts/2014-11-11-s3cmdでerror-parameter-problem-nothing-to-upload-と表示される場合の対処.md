---
id: 78
title: 's3cmdでERROR: Parameter problem: Nothing to upload.と表示される場合の対処'
date: 2014-11-11T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=78
#permalink: /?p=78
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/s3cmd%E3%81%A7error-parameter-problem-nothing-to-upload-%E3%81%A8%E8%A1%A8%E7%A4%BA%E3%81%95%E3%82%8C%E3%82%8B%E5%A0%B4%E5%90%88%E3%81%AE%E5%AF%BE%E5%87%A6/'
rss_pi_source_md5:
  - 04c3fb3ac8ff86f75701e07984d82739
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
s3cmd putで下記エラーが出たことがある

<pre class="lang:default decode:true">ERROR: Parameter problem: Nothing to upload.</pre></p> 

原因は簡単で宛先のS3のパスの最後に&#047;が抜けているだけだった。

Source: New feed