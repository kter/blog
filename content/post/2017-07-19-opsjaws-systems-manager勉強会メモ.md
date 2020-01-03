---
author: kter
categories:
- AWS
date: "2017-07-19T21:47:14Z"
id: 445
tags:
- AWS
- Systems Manager
title: OpsJAWS Systems Manager勉強会メモ
---
OpsJAWSの Meetup#12 ~ Systems Manager祭り ~に参加してきたので内容をメモ。

#### Amazon EC2 Systems Manager

OS内部の構成を管理

下記の自動化

* ソフトウェアインベントリの収集

* OSパッチの適用

* システムイメージの作成

* OS設定

Systems Managerは複数サービスで構成されている

##### Run Command

リモートから任意の実行が可能

JSONベースでコマンド・タスクを定義

SSHポートを開ける必要がない

##### ステートマネージャー

OSとアプリケーションの設定を定義、状態を維持する

JSONベースでポリシーを定義

EC2だけではなくオンプレも管理できる

##### インベントリ

ソフトウェアインベントリの情報収集

オンプレも対応

JSONベースで取得するデータを定義

ステートマネージャから定期的に呼び出せる

##### メンテナンスウィンドウ

事前に設定した時間でメンテナンスを実施

組み込み済みのコマンド、Run Commandの実行が可能

可用性と信頼性の向上

時間と繰り返し間隔を設定 -> メンテナンス対象のターゲットを指定 -> 実行するタスクを設定

##### パッチマネージャ

ベースラインを定義してWindows/Linuxのパッチを適用

Patch Baselineを使ってカスタムパッチポリシーを定義

##### オートメーション

シンプルなワークフローをつかって一般的なタスクを自動化

##### パラメータストア

IT資産の集中管理

ログイン、DB接続情報などを一元管理

Run Command, State Manager, Automationやコンソールから参照、更新可能

細かく権限管理して必要な人に必要な情報を提供

KMSで暗号化

IAMで制限できるため、パラメータ名の命名規則によって、環境ごとにアクセス可能なユーザを定義することができる

定義済みドキュメントが豊富

#### SSM Agent

Systems Managerの利用にはエージェントが必要

64bitだとAmazon AMI, CentOS, RHEL

Linuxではrootユーザでコマンドの実行が行われる

LinuxではS3からダウンロードしてインストールする
  
オンプレで使う場合、アクティベーションが必要。下記設定が必要

1. 名前

2. 許可するサーバ数

3. 使用するIAMロール

4. アクティベーションの有効期間

5. サーバに付与する名前

#### 利用例

AMI更新の自動化

AMIから自動的にインスタンスを作成、アップデート適用後AMIを作成し、インスタンスを削除

公式ドキュメントに手順が載っている

入門編スライド



<div style="margin-bottom:5px">
  <strong> <a href="https://www.slideshare.net/qryuu/systems-manager-ops-jaws" title="Systems manager 入門 ops jaws" target="_blank">Systems manager 入門 ops jaws</a> </strong> from <strong><a target="_blank" href="https://www.slideshare.net/qryuu">覚宏 伊藤</a></strong>
</div>

ハンズオンスライド



<div style="margin-bottom:5px">
  <strong> <a href="https://www.slideshare.net/qryuu/systems-manager-ops-jaw" title="Systems manager ハンズオン ops jaw " target="_blank">Systems manager ハンズオン ops jaw </a> </strong> from <strong><a target="_blank" href="https://www.slideshare.net/qryuu">覚宏 伊藤</a></strong>
</div>

#### ライトニングトーク

Systems Managerのインベントリ情報をExcelに出力するツールを作った。