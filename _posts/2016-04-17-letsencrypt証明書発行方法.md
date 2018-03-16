---
id: 16
title: LetsEncrypt証明書発行方法
date: 2016-04-17T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=16
#permalink: /?p=16
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/letsencrypt%E8%A8%BC%E6%98%8E%E6%9B%B8%E7%99%BA%E8%A1%8C%E6%96%B9%E6%B3%95/'
rss_pi_source_md5:
  - 76a7084816db9ebec2bfa3477214ddd2
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
Dockerで証明書を発行できる。

※外部から443にアクセスできるようポートを開けておく

<div class="highlight">
  <pre><code class="language-">docker run -it --rm -p 443:443 --name letsencrypt -v "/etc/letsencrypt:/etc/letsencrypt" -v "/var/lib/letsencrypt:/var/lib/letsencrypt" quay.io/letsencrypt/letsencrypt:latest certonly
</code></pre>
</div>

生成されたファイルは下記ファイルに保存される

<div class="highlight">
  <pre><code class="language-">/etc/letsencrypt/live/ドメイン名/fullchain.pem
/etc/letsencrypt/live/ドメイン名/privkey.pem
</code></pre>
</div>

Source: New feed