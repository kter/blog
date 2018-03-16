---
id: 49
title: 'AttributeError: &#039;module&#039; object has no attribute &#039;GPIO&#039;'
date: 2015-12-27T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=49
#permalink: /?p=49
rss_pi_source_url:
  - http://blog.kter.jp/blog/module-object-has-no-attribute-gpio/
rss_pi_source_md5:
  - 7566161c62368e18ad3c74fcce721ff0
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
PythonからwebiopiのGPIOを使おうとした時、

AttributeError: 'module' object has no attribute 'GPIO'

と表示される場合の対処。

### WebIOPi-0.7.1をRaspberry Pi2に対応させます

[こちら](http://www.knight-of-pi.org/webiopi-a-simple-but-great-web-api-for-the-raspberry-pi/)を参考に`python/native/cpuinfo.c`と`python/native/gpio.c`を修正します。

  * cpuinfo.c
    
    BCM2708をBCM2709に変更

  * gpio.c
    
    `define BCM2708_PERI_BASE 0x20000000`を`define BCM2708_PERI_BASE 0x3f000000`に変更

その後`setup.sh`を実行し直します。

### WiringPi2-PythonをPython3で動くようにします

Python3をインストール

`sudo aptitude install python3`

Python3をデフォルトにする
  
`<br />
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1<br />
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.4 2<br />
` 

WiringPi2-Pythonをインストールしなおす

`sudo ./setup.py install`

Source: New feed