---
id: 596
title: AWS S3 Glacierからリストアしてファイルをダウンロードする
date: 2018-09-06T22:31:02+09:00
author: kter
layout: post
image: 
categories:
  - AWS
tags:
  - AWS
  - S3
  - Glacier
---
# まとめ

Glacier状態のS3オブジェクトを取り出す際には、リストア期間を指定した上でrestore-objectを実行する必要があります。

# 手順

## リストア
recursiveオプションが無いため、list-objectsしてオブジェクトパスを取得してからrestore-objectを実行します。

```bash

for key in `aws s3api list-objects --bucket (バケット名) --prefix (ディレクトリ名) --output json | jq -r '.Contents[].Key'`; do echo $key; aws s3api restore-object --bucket (バケット名) --key $key --restore-request '{"Days": 3}';done
```

## ダウンロード

リストア済みのオブジェクトをダウンロードするときもresursiveが使えないため、list-objectsしてオブジェクトパスを取得してからダウンロードします。

```bash

for key in `aws s3api list-objects --bucket (バケット名) --prefix (ディレクトリ名) --output json | jq -r '.Contents[].Key'`; do echo $key; aws s3 cp s3://(バケット名)/$key .;done
```

