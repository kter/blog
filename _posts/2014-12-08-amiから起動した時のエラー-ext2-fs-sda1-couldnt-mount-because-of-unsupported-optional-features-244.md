---
id: 72
title: 'AMIから起動した時のエラー EXT2-fs: sda1: couldn&#039;t mount because of unsupported optional features (244).'
date: 2014-12-08T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=72
#permalink: /?p=72
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/ami%E3%81%8B%E3%82%89%E8%B5%B7%E5%8B%95%E3%81%97%E3%81%9F%E6%99%82%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC-ext2-fs-sda1-couldnt-mount-because-of-unsupported-optional-features-244/'
rss_pi_source_md5:
  - 630deb81efe7764055c485a29cd8b01e
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
ちょっと古いEC2のインスタンスのボリュームをスナップショット経由でAMIにしてそれを起動した時、一向に起動しない事案があった。

Instance SettingsのGet System Logでログを覗くと次のエラーが

<pre class="lang:default decode:true ">EXT2-fs: sda1: couldn't mount because of unsupported optional features (244).</pre></p> 

カーネルを同じにすればよいとのことだったので、既存のインスタンスと同じKernel IDを、Image作成時に指定すればよいのでした。
  
それからImage作成時にArchitectureの指定もしっかり合わせましょう。

Source: New feed