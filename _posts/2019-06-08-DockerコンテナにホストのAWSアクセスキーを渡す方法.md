---
id: 620
title: DockerコンテナにホストのAWSアクセスキーを渡す方法
date: 2019-06-08T12:00:00+09:00
author: kter
layout: post
image: 
categories:
  - AWS
tags:
  - AWS
  - Docker
---
## 課題

DockerコンテナからAWSのAPIにアクセスしたい場合、ホストがEC2ならIAMロールが使える。
しかしホストがローカルのMacの場合は、アクセスキーとシークレットアクセスキーを、どうにかしてコンテナに渡す必要がある。

## 結論

aws cliのconfigure getサブコマンドを使う。
具体的には下記のようにする。

```bash
#!/usr/bin/env sh
AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)

docker run --rm \
 -e AWS_REGION=ap-northeast-1 \
 -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
 -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
 (略)
```

このようにすればコンテナ内のAWC CLI指定の環境変数にアクセスキー等が格納されるので、そのままaws cliコマンドなどが使える。
プロファイルが複数ある場合は下記のようにして切り替えることもできる。

```bash
AWS_ACCESS_KEY_ID=$(aws --profile (プロファイル名) configure get aws_access_key_id)
AWS_SECRET_ACCESS_KEY=$(aws --profile (プロファイル名) configure get aws_secret_access_key)
```

参考
[get — AWS CLI 1\.16\.174 Command Reference](https://docs.aws.amazon.com/cli/latest/reference/configure/get.html)

[AWS CLI の設定 \- AWS Command Line Interface](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-configure.html#config-settings-and-precedence)

