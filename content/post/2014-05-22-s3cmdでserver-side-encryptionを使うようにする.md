---
author: kter
categories:
- 未分類
date: "2014-05-22T00:00:00Z"
id: 95
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- d1f97e001b5911ac7e9a2744dfb73433
rss_pi_source_url:
- http://blog.kter.jp/blog/s3cmd%E3%81%A7server-side-encryption%E3%82%92%E4%BD%BF%E3%81%86%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B/
title: s3cmdでserver-side-encryptionを使うようにする
---
s3cmdでserver-side-encryptionを使おうとして普通に&#8211;server-side-encryptionをオプションとしてつけても

<pre>s3cmd: error: no such option: --server-side-encryption</pre>

と言われるだけでだめだった。

その代わり、

    --add-header=x-amz-server-side-encryption:AES256

というオプションをつけるとちゃんと暗号化された。

要するにこんな感じでコマンドを実行すると

    s3cmd put --add-header=x-amz-server-side-encryption:AES256 uploadfile s3:&#047;&#047;bucketname&#047;</p> 

Source: New feed