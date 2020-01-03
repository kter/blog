---
author: kter
categories:
- 未分類
date: "2014-11-09T00:00:00Z"
id: 80
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- e7101d834e0d3e4f37771624195ba122
rss_pi_source_url:
- http://blog.kter.jp/blog/virtualbox%E3%81%ABwindows8%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%97%E3%82%88%E3%81%86%E3%81%A8%E3%81%97%E3%81%9F%E6%99%82%E3%81%AE%E3%82%A8%E3%83%A9%E3%83%BC%E3%81%AB/
title: VirtualBoxにWindows8をインストールしようとした時のエラーについて
---
VirtualBoxにWindows8をインストールしようとしたら次のようなエラーが表示されました。

Your PC needs to restart.
  
Please hold down the power button.
  
Error code: 0x000000C4
  
&#8230;

対処ですが、まず下記コマンドを実行してVMの名前を調べます。

<pre class="lang:default decode:true ">VBoxManage list vms</pre></p> 

次に下記コマンドを実行してからVMを起動し直すと、起動できるようになります。

<pre class="lang:default decode:true ">VBoxManage setextradata 調べた名前 VBoxInternal&#047;CPUM&#047;CMPXCHG16B 1</pre></p> 

参考URL:
  
<a href="https:&#047;&#047;4sysops.com&#047;forums&#047;topic&#047;windows-server-2012-r2-on-virtual-box-error-0x000000c4&#047;" title="https:&#047;&#047;4sysops.com&#047;forums&#047;topic&#047;windows-server-2012-r2-on-virtual-box-error-0x000000c4&#047;" target="_blank">Windows Server 2012 R2 on VirtualBox &ndash; Error 0x000000C4</a>

Source: New feed