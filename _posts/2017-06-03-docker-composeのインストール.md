---
id: 350
title: docker-composeのインストール
date: 2017-06-03T08:13:23+00:00
author: kter
layout: post
#guid: https://blog.kter.jp/?p=350
#permalink: /?p=350
categories:
  - AWS
  - Docker
  - Linux
---
AmazonLinuxでDockerが使いたくて、`yum install docker`でDockerをインストールしたものの、docker-composeが使えなかった。

調べたところ、docker-composeのインストールは、バイナリをダウンロードするだけのようだった。
  
具体的にはGitHubの[リリースページ](https://github.com/docker/compose/releases)からダウンロードする。

実際に実行したコマンドは次の通り。