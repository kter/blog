---
id: 613
title: 最速でLet's Encryptの証明書をGETする方法
date: 2019-03-14T12:00:00+09:00
author: kter
layout: post
image: 
categories:
  - 'Lets Encrypt'
tags:
  - 'Lets Encrypt'
---
# 前提

1. 更新したいドメインがRoute53で管理されている
2. Route53の操作権を持つIAMロールを割り当てたEC2で作業する
3. EC2でDockerが使える

# 手順

下記コマンドを実行するだけ。

```bash
sudo docker run -it --rm -e AWS_HOSTED_ZONE_ID=(対象ドメインのHosted Zone ID)  -v $PWD:/app xenolf/lego --path=/app --email="(メールアドレス)" --domains="(対象のドメイン)" --dns route53 run
```

証明書がカレントディレクトリのcertificatesディレクトリ以下に保存される。

