---
id: 599
title: Debian Jessie以降でDockerをインストールする
date: 2018-09-17T12:00:00+09:00
author: kter
layout: post
image: 
categories:
  - Docker
tags:
  - Debian
  - Jessie
---
Debian Jessie以降で下記コマンドを順に実行するとDockerがインストールできます。

詳細はこちらの[公式サイト](https://docs.docker.com/install/linux/docker-ce/debian/#install-docker-ce-1)を参照してください。


```
sudo apt-get update
sudo apt-get install      apt-transport-https      ca-certificates      curl      gnupg2      software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
# 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88で終わることを確認
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
# 動作確認
sudo docker run hello-world
```

