---
author: kter
categories:
- AWS
date: "2018-10-05T12:00:00Z"
id: 603
image: null
tags:
- AWS
- Redshift
- Kinesis
- Serverless
title: Analytics Architecture Night - Tokyo 201810自分用メモ
---
# Serverless Analytics on AWS

アマゾン ウェブ サービス ジャパン株式会社 Analytics Specialist SA 志村 誠

## サーバレスはセキュアでもある

* パッチが適用されていないサーバーは存在しない
* SSHもできない

## サーバーレスな分析

下回りを気にせず、やりたいことに集中

* データ収集: 設定だけで後は自動でデータを収集
* データ管理: データのスキーマを自動で登録・更新
* ETL: 処理を記述したスクリプトだけで前処理を実行
* クエリ: SQLだけで自由に分析
* 可視化: ブラウザから簡単にGUIで可視化

## AWSの分析サービス

複数あるが、最近のサービスであればサーバーレスに近い

### Amazon Kinesis Data

フルマネージド型リアルタイム大規模ストリーミング処理
KDS: ストリームデータを収集し、公団で各種分析やデータ保存を実施
KDF: ストリームを収集し、S3/Redshift/ES/Splunkに簡単に配信
KDA: 上記2つからストリームを取得しSQLを実施

### AWS Glue

完全マネージド型ETLサービス
Spark/PythonジョブによるETLを実行

### Amazon Athena

インタラクティブなクエリサービス
クエリエンジンとしてPrestoを用いS3上のデータに直接クエリを実行
実行した分だけ課金

### Amazon QuickSight

高速なSPICEエンジンと直感的な操作、専門家不要のBI
最大5ドル 1セッション30分で$0.3

### GlueベースのS3データレイク

各種データソースのカタログをGlueで一元的に管理
S3上のデータをAthena/Redshift Spectrum/EMRで分析

CSV/TSV/JSONをParquetに変換すると効率が良い。
-> S3ファイル追加のイベントトリガーでLambdaを起動してGlueジョブを実行するとよい
-> Kinesis FirehoseはParquetで出力できる

* ジョブワークフローの構築はStep Functionsで

## 使い分けのポイント

Glue/Athenaはあえて選択肢を絞ったり、チューニングの要素を絞ったりすることで、運用の負荷を下げ、本来の目的(ETL/分析)に集中できるようにしている。
まずはサーバーレス分析サービスでやりたいことが実現可能かどうか？
それでもだめならRedshift等使う

GlueはサーバーレスのETLサービスなので、なんでもできるわけではない。

## サーバレスな機会学習 

### Amazon SageMaker

開発: 主要ライブラリはインストール済み
学習: API実行してジョブを実行。同時分散学習が簡単にできる
推論: APIからエンドポイント作成。オートスケーリング, A/Bテストができる

使用する方法は次の通り。

* ビルドインアルゴリズムを使う。
* AWSがコンテナを用意しているフレームワークを使う
* 機械学習のコードとライブラリを含んだコンテナを作成

## まとめ

* サーバーレスを使うことでやりたいことに集中できる
* サーバーレスの選択肢を考えて当てはまらない場合は他の手を考える

# Amazon Kinesis によるストリームデータ分析および映像解析

アマゾン ウェブ サービス ジャパン株式会社 ソリューションアーキテクト 山﨑 翔太

ストリームデータとは?
多数のデータソースから継続的に生成されるデータ

* ログデータ
* 位置情報
* ユーザーの行動
* 購入履歴
* 音声・動画

より早く分析して価値を提供するためストリーム処理が必要

* 基本的にはAWSのサービスを数珠つなぎにしてデータの流れを作る
* できるだけ実装範囲と管理対象を減らす
    * 可能ならマネージドサービス同士で接続。できなければLambdaで接続。それでもだめならEC2上のアプリで接続
* 非機能要件も大切
    * どこかでコケると以降の処理が死ぬ
    * どこかで速度が出ないと移行の処理に影響が出る

-> Amazon Kinesis Family

* Amazon Kinesis Data Streams
* Amazon Kinesis Data Firehose
    * S3 / Redshift / ElasticSearch等に送れる
* Amazon Kinesis Data Analytics
    * ストリームデータに対してSQLを実行できる
* Amazon Kinesis Video Streams


Fluent plugin for Amazon Kinesis

* FluentdからKinesisにデータを送れる
* Firehoseなら直接S3における

CloudWatch Logs

* 転送時に複雑な処理が不要な時
* 他のAWSにサービスのログと統合管理したい時
    * Cloudwatch Logsサブスクリプションを使うとCloudWatch LogsからData Firehoseに送れる
    * Lambda関数の標準出力はCloudWatch Logs
    * コンテナのawslogsログドライバ
    * ECS/Fargateの標準出力もCloudWatch Logs
    * 他サービス(VPC フローログ、CloudTrail等)からのログ

ファンアウトして複数の配信先にデータを保存できる

* デフォルトでは配信先は一つしか選べない
* Lambda経由で配信先を複数にする

列思考フォーマットに変換してストリーミング・クエリ

* 訪問者数などは行志向だとIOが無駄。列志向なら効率がいい
    * FirehoseからParquet/ORC変換がストリーム内ででき、S3に保存
    * その後はAmazon Athena, Redshiftを使いBIで解析

Amazon Kinesis Video Streams

Video StreamsからRecognition Videoで処理し、結果のJSONデータをData Streamsにする。後は普通のストリームデータとして扱える

# Amazon Redshiftパフォーマンスチューニングテクニックと最新アップデート

アマゾン ウェブ サービス ジャパン株式会社 Specialist SA 大薗 純平

PostgreSQLをベースにDWH/分析特化型のアーキテクチャ

Redshift Spectrum: S3上のデータに対してクエリを書けるエンジン
メタデータはGlueに

アーキテクチャ
シェアードナッシング: ディスクをノードで共有していない。ノードとディスクがセット
MPP: 1つのタスクを複数のノードで分散実行する仕組み
スライス: メモリとディスクをノード内で分割した論理的な処理単位

Spectrum

* 事前のデータロード不要。S3上のデータに直接SQLを実行
* RedshiftとS3それぞれに存在するデータを結合
* スキャンしたデータ量で課金

Redshiftのチューニング

* ディスクIOを削減する
    * まずは読み出す範囲・サイズをいかに減らせるか
* ノード間通信を削減する
    * 通信しないようなデータ配置
* クエリごとに必要なリソースを適切に割り当てる
    * メモリ資源を効率的に利用

ディスクIOを削減する

* 列志向なので、SELECT * FROMのような全選択は不用意に使用しない
    * 必要な列のみを読み取る
    * サブクエリとかも
* 列の圧縮で1度のディスクアクセスで読み込めるデータ量が多くなり、速度の向上が見込める
    * 圧縮エンコーディングはANALYZE COMPRESSIONコマンドで推奨を確認する。
        * 選択に迷ったらまずはZSTDまたはLZOを選ぶ
            * ZSTDは圧縮率が高く、容量削減に有効だが、圧縮展開のオーバーヘッドが高め
            * LZOは逆に圧縮率はZSTDに劣るが、パフォーマンス面では優れている
* ゾーンマップを有効活用
    * データが格納されている各ブロック(1MB単位)に関するメタデータをリーダーノードのインメモリ上に格納 (最小・最大値が入る)
        * データをどの列順にソートするかをテーブルごとにソートキーとして指定
        * **頻繁に使われる絞り込み(WHERE句)条件キーが筆頭候補**
* 列サイズは可能な限り最小限に留める
    * クエリ実行時Redshiftは宣言された列幅に応じたバッファーを割り当てる
        * そのため必要以上に長い列はメモリの無駄遣い

クエリ性能が期待より出ていない場合

* マネジメントコンソールなどで実行計画、実績統計、リソース使用状況を確認する
* 代表的なケースの一つはノード間のネットワークデータ転送のボトルネック

ノード間通信を削減する

* 実行計画に、DS_*オペレータとその実時間を確認
    * DS_BCAST_INNERを見つける
        * ジョイン時の内部表が全ノードにブロードキャストされていることがわかる
    * 他にはDS_DIST_ALL_INNER, DS_BCAST_BOTHには注意
    * テーブルごとに分散方式を検討
        * KEY: 同じキーは同じスライスへ
        * ALL: 各ノードに全データ
        * EVEN: ラウンドロビンで均等分散 (デフォルト)
    * 処理をなるべく同じノード内に閉じて行うようにする
        * パターンは下記3つ。これらはすべてノード内に処理が閉じる
            * 各テーブルでジョインに使用するカラムをDISTKEYとして作成
            * ジョインするテーブルのうち一方をALL分散で作成
            * ジョインさせないよう、非正規化しEVEN分散
    * ただしデータの偏りに注意
        * ノード間のデータ容量の方よりはクエリー実行時間に影響を与える
        * 違うリソースの使い方をしているノードがないかは常に確認

クエリごとに必要なリソースを適切に割り当てる

* WLMによる実行の制御: キューとスロット
    * 長期実行されるクエリーは短期実行クエリーをキュー内に待たせることがある
        * 1時間のクエリーが1時間半かかってもいいが、10秒で終わるクエリが30分掛るのはユーザーエクスペリエンスが悪い
        * デフォルトキューはスロット（並列実行数）が５つ
        * キューで優先度が定義でき、長時間用と短時間用クエリでキューを分ける
    * クエリーキューホッピングを使う
        * クエリの振る舞いに応じて自動的に次に条件マッチするキューにクエリーを投入する機能
        * 時間がかかりすぎるクエリーをインタラクティブなクエリから切り離し、別キューでゆっくり実行させる事が可能
            * マネジメントコンソールから設定可能。上から評価される。
            * CPU使用率や実行時間,ジョイン対象行等を組み合わせて設定可能
    * ショートクエリーアクセラレーションの活用
        * 機械学習によってクエリの実行時間を予測する
        * ショートクエリと判断されたクエリは専用の高速キューにルーティングされる
        * 専用キューがある
        * デフォルトで有効
    * 結果セットのキャッシュ
        * 結果をリーダーノードでキャッシュ
        * デフォルトで有効

Redshift Spectrumを使ってネスト化されたデータに対するクエリが投げられる

Redshift Advisor

Query editor

* Redshiftから直接クエリを投げられる

# 所感

サイト訪問者のリアルタイム分析とか入店者のリアルタイム分析とかできそうで夢が広がりますね。
知識としては知っていましたが実際に説明を受けてみるとすごくわくわくしてきます。

またサーバレスはセキュアでもあるということ、意識したことなかったのですが確かにそうですよね。
自前で運用だとどうしてもパッチの適用が遅れたりできない時とかありますから…。

