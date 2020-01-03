---
author: kter
categories:
- AWS
- Docker
- Linux
date: "2017-06-03T08:13:23Z"
id: 350
title: docker-composeのインストール
---
AmazonLinuxでDockerが使いたくて、`yum install docker`でDockerをインストールしたものの、docker-composeが使えなかった。

調べたところ、docker-composeのインストールは、バイナリをダウンロードするだけのようだった。
  
具体的にはGitHubの[リリースページ](https://github.com/docker/compose/releases)からダウンロードする。

実際に実行したコマンドは次の通り。