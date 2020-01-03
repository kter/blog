---
author: kter
categories:
- 未分類
date: "2014-03-07T00:00:00Z"
id: 102
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- a5fcd71873d139a9301f932ce16ae0c1
rss_pi_source_url:
- http://blog.kter.jp/blog/yum%E3%81%A7fastestmirror%E3%81%8C%E6%9C%89%E5%8A%B9%E3%81%AB%E3%82%82%E3%81%8B%E3%81%8B%E3%82%8F%E3%82%89%E3%81%9A%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89%E3%81%8C%E9%81%85%E3%81%84/
title: yumのfastestmirrorが有効にもかかわらずダウンロードが遅い場合
---
yumプラグインのfastestmirrorが有効にもかかわらずダウンロードが遅い場合の対処法

Ctrl+cを押しましょう。次のミラーサイトへの接続で続行されます

&nbsp;

&#047;var&#047;cache&#047;yum以下にあるtimedhosts.txtに各ミラーサイトの応答速度が書いてるので、これを削除してリセット。という手もありますが、大抵の場合は遅かったらもう次のミラーサイトで接続というようにやっちゃった方がいいんじゃないかなーっと思います

それでも駄目ならネットワークインターフェースが怪しいので<a title="Cannot set new settings: Invalid argument" href="http:&#047;&#047;img.kter.jp&#047;?p=96" target="_blank">以前書いた記事</a>を参考に、どうぞ！

Source: New feed