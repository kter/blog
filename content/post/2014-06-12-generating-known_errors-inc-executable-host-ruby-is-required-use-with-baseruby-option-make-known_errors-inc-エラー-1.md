---
author: kter
categories:
- 未分類
date: "2014-06-12T00:00:00Z"
id: 93
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- 86147e8e58407543f195a35ebcc67eac
rss_pi_source_url:
- http://blog.kter.jp/blog/generating-known_errors-inc-executable-host-ruby-is-required-use-with-baseruby-option-make-known_errors-inc-%E3%82%A8%E3%83%A9%E3%83%BC-1/
title: 'generating known_errors.inc executable host ruby is required. use &#8211;with-baseruby
  option. make: *** [known_errors.inc] エラー 1'
---
Ruby2.1.2のソースインストール時に次のようなエラーが表示された

&nbsp;

> generating known_errors.inc
  
> executable host ruby is required. use &#8211;with-baseruby option.
  
> make: \*** [known_errors.inc] エラー 1
> 
> &nbsp;

RubyをインストールするにはRubyが必要とのことでした

が今まではRubyが入っていない状態でもインストールできていたので、ホストを再起動を試したらインストールできました。

思い当たる節がyum updateとyum groupinstall &#8220;Development Tools&#8221;を行ったということくらいしかありませんが、多分このせいなんだろうなぁ

Source: New feed