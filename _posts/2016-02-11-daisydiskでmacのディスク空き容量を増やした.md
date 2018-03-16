---
id: 28
title: DaisyDiskでMacのディスク空き容量を増やした
date: 2016-02-11T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=28
#permalink: /?p=28
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/DaisyDisk%E3%81%A7Mac%E3%81%AE%E3%83%87%E3%82%A3%E3%82%B9%E3%82%AF%E7%A9%BA%E3%81%8D%E5%AE%B9%E9%87%8F%E3%82%92%E5%A2%97%E3%82%84%E3%81%97%E3%81%9F/'
rss_pi_source_md5:
  - 55cefc4980b41b4292a1b03213e6f331
rss_pi_canonical_url:
  - my_blog
image: /wp-content/uploads/2016/02/evernote.png
categories:
  - 未分類
---
Macの空きディスク容量が1割を切ったので、原因となっているファイルを調べてみた。

フリーのツールもいくつかあるのだが、今回は[DaisyDisk](https://daisydiskapp.com/)という有償のアプリを使って調べてみた。

256GBのSSDの調査に数十秒かかり、後はディレクトリをたどりながら、今いるディレクトリの使用容量を円グラフで表示できる。

これで調べてみるとどうやらEvernoteで約20GB使っているようだった。

![Evernote使用ディスク容量](http://img.kter.jp/2016/0211/evernote.png)

Evernoteは今後デスクトップアプリ版ではなく、Webアプリ版を使用することにして、アプリはAppCleanerで削除しました。

![Evernoteアプリ削除](http://img.kter.jp/2016/0211/evernote-used-size.png)

というような作業を繰り返し、最終的にホームディレクトリの使用量を142GBまでに広げることができました。

![deleted](http://img.kter.jp/2016/0211/deleted.png)

Source: New feed