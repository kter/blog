---
author: kter
categories:
- AWS
date: "2018-09-06T12:00:00Z"
id: 598
image: null
tags:
- AWS
- lambda
title: 自分用AWS クラウドサービス活用資料集メモ AWS Lambda編
---
# AWS Lambdaとは

* インフラを一切期にすることなくアプリケーションコードを実行できるコンピュートサービス
    * 実行基盤はすべてAWSが管理
    * AWSサービスと連携し、イベントドリブンなアプリケーションを作れる
    * コード実行時間に対して課金

→やりたいことだけに集中できる

# ユースケース

* S3のバケットに画像が保存されたらサムネイルイメージを用意
* DynamoDBに保存されるアドレスが全て正しい形式化チェックしたい

# 詳細

* 対応言語
    * JavaScript
    * Java
    * Python
    * Go
* メモリ容量に応じてCPU能力が変動
* 隔離されたコンテナ内で実行される
* 対応起動トリガー
    * API Gateway
    * AWS IoT
    * Alexa Skills Kit
    * Alexa Smarat Home
    * CloudFront
    * CloudWatch Events
    * CloudWatch Logs
    * CodeCommit
    * Cognito Sync Trigger
    * DynamoDB
    * Kinesis
    * S3
    * SNS
    * SQS
* モバイル・WebアプリからSDKを利用して呼び出すこともできる
    * モバイルSDK経由の実行だとデバイス、アプリ、アイデンティティ情報にアクセス可能
* 同期実行と非同期実行が選べる
    * 非同期実行の場合レスポンスはリクエストが正常に受け付けられたかどうかのみ
* DynamoDBとKinesisのイベントはLambdaが自動的に取得しに行く（PULLモデル)
    * Lambdaが取得しに行くのでその権限が必要

