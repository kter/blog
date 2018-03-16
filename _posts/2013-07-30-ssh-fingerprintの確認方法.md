---
id: 122
title: SSH fingerprintの確認方法
date: 2013-07-30T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=122
#permalink: /?p=122
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/SSH-fingerprint%E7%A2%BA%E8%AA%8D%E6%96%B9%E6%B3%95/'
rss_pi_source_md5:
  - 3c5ea3580885e20e3ea7196d9131fe7a
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
<div class="highlight">
  <pre><code class="language-">ssh-keygen -lf /etc/ssh/ssh_host_rsa_key.pub
</code></pre>
</div>

OS再インストールした時、remote host identification has changedとか言われるのはこの公開鍵が変わるからなのね。

参考

<http://d.hatena.ne.jp/Artisan/20130325/1364222117>

Source: New feed