---
author: kter
categories:
- 未分類
date: "2013-12-03T00:00:00Z"
id: 109
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- c4a6533d917c3f78b6f0a622c510615f
rss_pi_source_url:
- http://blog.kter.jp/blog/zabbix-install-error/
title: 'configure: error: Jabber library not found'
---
Zabbix 1.8をソースからインストールした時次のエラーが発生。

<div class="highlight">
  <pre><code class="language-">checking for iksemel support… no
configure: error: Jabber library not found
</code></pre>
</div>

iksemeはEPELリポジトリからインストールします。

AmazonAMIならば次のコマンドでiksemelインストールできるでしょう

<div class="highlight">
  <pre><code class="language-">sudo yum --enablerepo=epel install iksemel iksemel-devel
</code></pre>
</div>

Source: New feed