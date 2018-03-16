---
id: 54
title: Raspberry PiでWiFiに繋ぐ方法
date: 2015-12-18T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=54
#permalink: /?p=54
rss_pi_source_url:
  - http://blog.kter.jp/blog/raspberry-pi-wifi/
rss_pi_source_md5:
  - 4f9696fde0913654ef2fafc5b1b86065
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
Raspberry PiでWiFiに繋ぐ方法

Xが立ち上がっていない場合のWiFiの設定方法が分からなかったのでメモ。

次のファイルに下記内容を追記すれば良い。
  
繋げたいWiFiが複数ある場合は、そのままnetworkの項目を増やせばいい。

/etc/wpa_supplicant/wpa_supplicant.conf

<div class="highlight">
  <pre><code class="language-">
network={
  ssid="SSID"
  psk="PASSWORD"
  proto=RSN
  key_mgmt=WPA-PSK
  pairwise=CCMP
  auth_alg=OPEN
}
</code></pre>
</div>

Source: New feed