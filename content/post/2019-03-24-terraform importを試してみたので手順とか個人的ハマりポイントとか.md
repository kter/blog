---
author: kter
categories:
- Terraform
date: "2019-03-24T12:00:00Z"
id: 614
image: null
tags:
- Terraform
title: terraform importを試してみたので手順とか個人的ハマりポイントとか
---
# terraform import手順

簡単な例でS3バケットのimportをしてみる。
先に書いておくと、terraform importは現状のAWSリソースの情報をいい感じにterraformのtfファイルに書き起こしてくれるわけではなく、tfstateファイルにリソース情報を記録してくれるだけ。
あとはterraformのドキュメントとtfstateファイルを参考にtfファイルを手書きする感じとなる。

## 1. importしたいリソースをmain.tfに記載

`resource (リソースタイプ) (リソース名)` の形式で記載する。
※リソース名はterraform内の識別名

```:main.tf
resource "aws_s3_bucket" "test" {
}
```

## 2. terraform importコマンドでterraform.tfstateファイルに状態を保存


`terraform import (リソースタイプ).(リソース名) (importするリソースID)`の形式でコマンドを実行する。
※S3バケットの場合importするリソースIDはバケット名

```bash
terraform import aws_s3_bucket.test tomohiko.io
```

※もしエラーが出たら`terraform init`を実行してAWSプラグインをインストールする

## 3. terraform.tfstateファイルからmain.tfファイルに必要なパラメータを抜き出しmain.tfファイルに記載

terraform.tfstateファイルにimportしたリソースの状態が記録されるので、その情報とterraformのドキュメントを参考にmain.tfファイルを完成させる。

※デフォルト設定のS3を作成するだけならbucketの指定だけで大丈夫です。

```:main.tf
resource "aws_s3_bucket" "test" {
  bucket = "tomohiko.io"
}
```

# 個人的ハマりポイント

## IAM Role

IAM Roleを定義するためには下記3つのresourceと1つのdataを定義する必要がある。

policy

* aws_iam_role
* aws_iam_policy_document
* aws_iam_role_policy

data

* aws_iam_policy_document

自分の書いたコードの一部を抜粋するとこんな感じ。

```
resource "aws_iam_role" "IAMロール名" {
  name               = "IAMロール名"
  assume_role_policy = "${data.aws_iam_policy_document.IAMロール名.json}"
}

data "aws_iam_policy_document" "IAMロール名" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "IAMロール名" {
  name   = "IAMロール名"
  role   = "${aws_iam_role.IAMロール名.id}"
  policy = "${data.aws_iam_policy_document.IAMロール名-policy.json}"
}

data "aws_iam_policy_document" "IAMロール名-policy" {
  statement {
    actions = [
        "s3:*"
    ]
    resources = [ "*" ]
  }
}
```

## ECS

コンテナ起動時にこんな感じのエラーが出る

```
CannotPullContainerError: API error (500): Get https://111122223333.dkr.ecr.us-east-1.amazonaws.com/v2/: net/http: request canceled while waiting for connection"
```

AWSのドキュメントに全て書いてあるが、パブリックサブネット+パブリックIP自動割当じゃないとインターネットに接続できず、コンテナイメージをプルできないため。
(もしくはIP自動割当OFF+NATゲートウェイを設置&ルーティング設定)

[コンテナイメージをプルできないエラー \- Amazon Elastic Container Service](https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task_cannot_pull_image.html)

