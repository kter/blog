---
author: kter
categories:
- Linux
date: "2019-06-08T12:00:00Z"
id: 619
image: null
tags:
- Mac
- Linux
- OpenSSH
title: UseKeychainが設定されているMacのssh configをLinuxで使い回す
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

