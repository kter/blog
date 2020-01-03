---
author: kter
categories:
- AWS
date: "2018-05-26T11:34:00Z"
id: 586
image: null
tags:
- AWS
- Auto Scaling
title: 自分用AWS クラウドサービス活用資料集メモ Auto Scaling編
---

#### [Auto Scaling](https://aws.amazon.com/jp/autoscaling/)

情報元: [AWS Black Belt Online Seminar 2017 Auto Scaling](https://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-online-seminar-2017-auto-scaling)

* 動的スケーリング3種
    * ChangeInCapacity
        * 指定したインスタンス数だけ容量を増減
        * ex. アラームが起きたら2台増やす
    * ExactCapacity
        * 指定したインスタンス数に容量を変更
        * アラームが起きたら2台にする
    * PercentChangeInCapacity
        * 指定したインスタンス数に容量を変更
        * 現在のサイズから20%増やす
* 負荷が予想できるなら: スケジュールベース
* 予定された負荷の対策: 手動スケーリング
* 予測できない緩やかな負荷: 動的スケーリング
* ヘルスチェック
    * EC2: ステータスがrunning以外の状態を以上と判断
    * ELB: ELBのヘルスチェックを利用
* クールダウン: スケーリングアクション実行後、指定した時間ないは次のスケーリングアクションを実行しない仕組み
    * シンプルスケーリングポリシーのみ対応
* ターミネーションポリシー: スケールイン時どのインスタンスから終了するか定義
    * OldestInstance / NewestInstance
    * OldestLaunchConfiguration
    * ClosestToNextInstanceHour (次の課金が始まるタイミングが最も近いインスタンス)
    * Default (OldestLaunchConfigurationとClosestToNextInstanceHourを順に適用し、複数インスタンスが残ればランダム)
    * インスタンス保護対象は除外
* インスタンスのアタッチ・デタッチ
    * インスタンスのアタッチ: Auto Scaling Groupに追加できる。Desired Capacityが自動で追加される
    * インスタンスのデタッチ: Auto Scaling Groupから取り除ける。Desired Capacityは変更されないため、新規インスタンスが追加される
    * どちらもELBとは連動する。
* スタンバイ: ELBからデタッチされ、トラフィックが流れないようになる
    * Desired Capasityも自動で変更される
* ライフサイクルフック: Auto Scalingによるインスタンス起動・終了を待機させ、起動時または終了時にカスタムアクションを実行できる仕組み
    * インスタンス起動・終了処理を待機させ、メッセージを通知。SNS、SQS、CloudWatchイベントに送られる
    * 待機時間にカスタムアクションを(初期化・終了処理）を実行
    * ライフサイクルの終了または待機時間延長コマンドを実行
* 突発的なスパイクには向いていない
    * CloudFrontにオフロード
    * API Gatewayでスロットリング
    * サイトを静的ページに切り替える
* アーキテクチャとしてはSQSやECS、Blue Green(ASGをCloudFormationで自動作成)等が挙げられる。
* Application Auto Scaling: Auto Scalingと似たUXでAWSリソースの自動スケールを実現
    * ECS
    * Spot Fleet
    * EMR

