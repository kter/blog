---
id: 619
title: UseKeychainが設定されているMacのssh configをLinuxで使い回す
date: 2019-06-08T12:00:00+09:00
author: kter
layout: post
image: 
categories:
  - Linux
tags:
  - Mac
  - Linux
  - OpenSSH
---
## 課題

Dockerコンテナ内でMacのSSH設定を引き継ごうと思い、ボリュームマウントで対応したものの、Macでしか使えないUseKeychainが邪魔をしてエラーとなってしまう。

## 結論

IgnoreUnknownオプションを使う。
具体的には下記のようにする。

```
IgnoreUnknown UseKeychain
  UseKeychain yes
```

参考
[Technical Note TN2449: OpenSSH updates in macOS 10\.12\.2](https://developer.apple.com/library/archive/technotes/tn2449/_index.html)

