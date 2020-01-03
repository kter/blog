---
author: kter
categories:
- AWS
date: "2018-05-23T00:13:00Z"
id: 584
image: null
tags:
- AWS
- Amazon EC2
title: 自分用AWS クラウドサービス活用資料集メモ Amazon EC2編
---
# AWS クラウドサービス活用資料集メモ

## サービス別資料

### コンピューティング

#### [Amazon EC2](https://aws.amazon.com/jp/ec2/)

情報元: [20180411 AWS Black Belt Online Seminar Amazon EC2
](https://www.slideshare.net/AmazonWebServicesJapan/20180411-aws-black-belt-online-seminar-amazon-ec2)

* 最新のC5, M5インスタンスはXenベースではなく、KVMベース
* 最小: 1vCPU, 0.5GBメモリ
* 最大: 128vCPU, 約4TBメモリ
* EC2インスタンスファミリー一覧
    * 汎用、コンピューティング最適化、ストレージ最適化、メモリ最適化、GPU・FPGAアクセラレーテッド
* T2インスタンスのCPUクレジット動作について
    * CPUクレジット1につきCPUコアの最大パフォーマンス（バースト性能）を1分間提供
    * T2 Unlimitedの場合24時間分のCPUクレジットを前借りして利用できる
    * 前借りクレジットを使い切った状態においてはvCPU時間あたりLinuxでは$0.05/h, Windowsで$0.096/hが加算請求される
    * 初期CPUクレジット、一時間あたりに受け取るCPUクレジット、ベースラインパフォーマンス(CPU使用率)、最大獲得CPUクレジットバランスはインスタンスタイプごとに異なる
* Dedicated Hostsの場合、AWSまたはMarketplaceで提供されているRHEL, SUSE Linux, Windows　AMIは使えないので注意
* Amazon EC2 Bare Metalについて
    * ハードウェアへのダイレクトアクセスを提供するインスタンス
    * AWS各種サービスとの連携が可能
    * 仮想化環境上からは利用できないエミュレータや、独自のハイパーバイザーを導入するときなどに利用
* 拡張ネットワーキングについて
    * Intel 82599VF (ixgbevf)
        * M4(m4.16xlarge以外), C3, C4, D2, I2, R3で使える
    * Elastic Network Adapter (ENA)
        * C5, F1, G3, H1, I3, M5, P2, P3, R4, X1, m4.16xlargeで使える
* Cluster Placement Groupsについて
    * インスタンス間通信を最適化（広帯域、低レイテンシ、高PPS(packets per seconds)
    * 単一AZに限る
    * M4, M5, C3, C4, C5, R3, R4, X1, X1e, D2, I2, I3, F1, G2, P2, P3に対応
* EBSボリュームタイプ
    * プロビジョンドIOPS SSD, 汎用SSD, スループット最適化HDD（ビッグデータ、DWH,ログデータ用）, コールドHDD (低頻度データ用)
* EBS最適化オプション: 通常とネットワークとは別にEBS専用帯域を確保するオプション
* Amazon EC2 Elastic GPU for Windows: EC2インスタンスにGPUによる3Dグラフィックス機能をアタッチ。T2インスタンス等で利用することでG2/G3インスタンスに比べて安価にGPUを利用できる。
* Spread Placement Group: 複数のインスタンス起動時にそれぞれ別の物理サーバに配置される
* EC2のSLAは99.99%。満たない場合はServiceクレジットを返還
* Launch Template: EC2起動時の設定項目をテンプレート化して、起動をシンプル化できる
* EC2は誤って起動しないよう、初期状態ではリージョンごと20インスタンスしか起動できない
* EC2とEBSは秒単位の課金だが、最小請求期間は1分。対象サービスはEC2, EBS, EMR, AWS Batch。ただし追加課金のないLinux OSのみで**Windows RHEL等は対象外**。
* EC2の購入オプション: オンデマンドインスタンス、リザーブドインスタンス、スポットインスタンス、専用ホスト(Dedicated Hosts), ハードウェア専有インスタンス(Dedicated Instance)
* Amazon Inspector: 自動化されたEC2のセキュリティ評価サービス (エージェントを導入するホスト型診断)

#### [Amazon EC2 Windows](https://aws.amazon.com/jp/windows/)

情報元: [AWS Black Belt Online Seminar Amazon EC2 - Windows
](https://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-online-seminar-amazon-ec2-windows)

* 下記バージョンのWindowsが利用可能
    * Windows Server 2012 R2
    * Windows Server 2012
    * Windows Server 2008 R2
    * Windows Server 2008
    * Windows Server 2003 R2
* Windowsのバージョンに応じたSQL Server導入済みイメージもある
    * SQL Server Express Edition (無料)
    * SQL Server Web Edition (時間課金)
    * SQL Server Standard Edition (時間課金)
* Windows AMIは下記ツールがインストールされており、定例パッチ(毎月第2火曜日)の5営業日以内に更新されたWindwos AMIを提供している
    * EC2Configサービス
    * 準仮想化（PV)ドライバ
    * AWS Tools for Windows PowerShell
    * AWS CloudFormationヘルパースクリプト
* なおAmazon SNSでAMIのリリースと利用不可の通知を受け取ることが可能
* EC2Configサービスではインスタンス起動時に下記タスクを実行
    * 暗号化パスワードの設定
    * ユーザーデータの実行
    * Windowsのアクティベーション
    * ボリュームのフォーマット及びマウント
* Sysprep: カスタムAMIを作成するためのツール
* BYOLインスタンスはハードウェア専有インスタンスもしくは専有インスタンスで動かす必要がある。
* CloudWatch Logsを使ってログ監視、保存ができる。保存期間は一日から永久
* AWS Diagnostics for Microsoft Windows Serverツールを使って、Windowsインスタンスのトラブルシュートができる。
    * ネットワーク、ドメインとコンピュータ名、ライセンスアクティベーション、時刻設定とタイムゾーン、インストールされているドライバ、Windows firewallとSecurity Groupsの設定、インストール済みのアップデート、一週間以内のミニダンプファイル (クラッシュ時の)

#### [Amazon EC2 HPC](https://aws.amazon.com/jp/hpc/)

情報元: [AWS Black Belt Online Seminar 2016 HPC分野でのAWS活用](https://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-online-seminar-2016-hpcaws)

* HPC (High Performance Computing)
    * 膨大な料の数値計算や処理を行う
    * 同名のサービスがあるわけではない。上記をEC2で行う
* CfnCluster: ジョブ本数を監視して計算ノードを自動でスケールさせるクラスタの構築ツール
* Graphics Workspaces: GPUを搭載したWorkspaces (3Dモデラー、エンジニア用)

#### [[Amazon EC2] リザーブドインスタンス](https://aws.amazon.com/jp/ec2/pricing/reserved-instances/)

情報元: [AWS Black Belt Online Seminar 2017 AWS のコスト最適化 リザーブドインスタンス](https://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-2017-cost-optimization-reserved-instance)

* DB, キャッシュサーバ, 常時起動するWeb/Appサーバに最適
* RIは権利の購入なのでインスタンスIDと紐付かない。条件に合致するインスタンスがあれば自動的に割引料金が適応される。
* スコープをリージョン指定した場合キャパシティの予約はなし。AZ指定だと指定AZのキャパシティの予約がある。
* **リージョン指定の場合**、同一インスタンスファミリー内の*別サイズ*のインスタンスにも適用される
* スタンダードの特徴
    * 割引率が最も高い
    * RI権利の変更はできない (同一ファミリー内でのインスタンスタイプ分割/統合, AZ変更は可能)
    * 契約期間は1年または3年

* コンバーチブルの特徴
    *　同等以上の価値を持つRIに差額の支払いで交換が可能 (ファミリー、サイズ、プラットフォーム、手ナンシー、支払い方法の変更が可能)
        *　下位の支払い方法は選択できない (全前払い -> 前払いなし等)
    *　交換時の新価格が適用される
    *　契約期間は１年または３年
* RDSの場合
    * スタンダードRIのみ選択可能。インスタンスタイプの分割/統合はできない
    * 正規化係数により割引が自動割引になる。r3.large -> r3.xlargeに変える場合、r3.largeのRIを買い増すことで対応可能。
* ElasciCacheとRedshift
    * 正規化係数による自動割引適用はない
    * スタンダードRIのみ
    * ElastiCacheは重度使用の１種類のみ

#### [[Amazon EC2] スポットインスタンス](https://aws.amazon.com/jp/ec2/pricing/spot-instances/)

情報元: [AWS Black Belt Online Seminar 2016 Amazon EC2 Spot Instances（スポットインスタンス）](https://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-online-seminar-2016-amazon-ec2-spot-instances)

* 種類
    * スポットインスタンス
        * 余ったインスタンスの需要と供給のバランスで価格が変動
        * 入札価格がスポット価格を上回り、スポットプールに空きがあった場合利用可能
        * ターミネートはインスタンスからメタデータをGETすることで２分前から通知を受け取ることが可能 (５秒毎のポーリングを推奨)
        * ワンタイムリクエストの場合はターミネート後はインスタンスは起動しない
        * 永続リクエストの場合はターミネート後もキャンセルもしくは有効期限が切れるまでインスタンスが起動する
    * スポットブロック
        * 1~6時間の使用予定期間を指定することで、指定した時間内にブロック価格が高騰してもターミネートされない
    * スポットフリート
        * 配分戦略に応じて複数のスポットプールを自動的に利用
            * Diversified戦略: 選択したプール内のできるだけ多くのプールに分散
            * Lowest Price戦略: 選択したプール内、最も安価なプールを優先的に使う
        *フリート全体でターゲット容量(インスタンス数 or vCPU数)を満たす

#### [[Amazon EC2] Instance Store & Elastic Block Store](https://aws.amazon.com/jp/ebs/)

情報元: [[AWSマイスターシリーズ] Instance Store & Elastic Block Store](https://www.slideshare.net/AmazonWebServicesJapan/aws-instance-store-e)

* AMIはストレージとしてEBS-Backed AMIとInstance Store-Backed AMIの二種類が選べる
    * Instance Store-Backed AMIは停止のオプションはない
    * EC2を終了するとデータが消える
    * EC2 / AMIの場合はRoot Device Typeの項目からInstance Storeかの確認ができる
* Instance Storeについて
    * EC2の物理筐体のローカルディスク
    * インスタンスタイプにより個数, HDD/SDD, サイズが決定
    * 無料で使える
    * ネットワークの影響を受けにくい
    * インスタンス停止でデータが消える（ただし再起動では消えない
* t1.micro, c1.mediumではスワップ領域が用意されている
* Ephemeral DiskのBlock Device mapping確認
    * EC2: ```GET http://169.254.169.254/latest/meta-data/block-device-mapping/``` で確認できる
    * AMI: Block Deviceの欄で確認できる
* Instance StoreのAMI化はAMI作成時のボリューム化としてInstance Storeを選択する
* Ephoemeral DiskのCloud WatchメトリクスはEC2を確認する（EBSの場合はEBSのDisk Metricを確認する）。
* EBSはAZに存在。ただし内部的に冗長化されている
* EBSスナップショットは2回目以降は差分のみS3にバックアップされる
* EBS-Optimized InstanceはEBS用にネットワーク帯域を最適化される。500Mbps ~ 20000MBpsEBS用に帯域が確保される。
* シミュレーションはLinuxの場合Fio等がある
* Ephemeral DiskはEC2と同様に冗長化・レプリケーション、更にS3へのバックアップをすることで耐久性を向上させることができる。

#### [[Amazon EC2] Instance Store & Elastic Block Store](https://aws.amazon.com/jp/ebs/)

情報元: [20120625 aws meister-reloaded-sg-vmie-public](https://www.slideshare.net/AmazonWebServicesJapan/20120625-aws-meisterreloadedsgvmiepublic)

* AWS Storage Gateway: 既存データセンターのデータをクラウドストレージへ安全にバックアップするサービス
    * データ転送・保存を暗号化
    * 遠隔バックアップ・DRコストを最小化
    * 仮想アプライアンスとして提供されており、iSCSI対応のストレージになる
    * ESXi 4.1/5.0に対応
    * 書き込まれたデータは自動的にS3に転送される
    * 差分のみ圧縮して暗号化して転送される
    * リカバリはEC2のEBSでもオンプレミスのデータセンタでも可能
    * バックアップ・DRの他にデータ移行にも使える
    * アップデートやパッチは自動適用される（メンテナンスウインドウ設定可能）
    * Cloud Watchで監視・ログ・アラーム設定を行える
    * AWS Direct Connectも利用できる
        * AWSとデータセンター、オフィス、コロケーション環境間にプライベート接続を確立するサービス
        * 高スループット、低レイテンシ
        * 一貫性のあるネットワーク体験
* VM Import/Export
    * データセンターのVMアプリケーションのEC2への移行
    * ディザスタリカバリ用イメージの作成
    * 別途料金はかからない
    * 対応OS: Windows Server 2003 R2, Windows Server 2008 / R2
    * 対応フォーマット: VMware vSphere VMDK, Microsoft Hyper-V VHD, Citrix XenServer VHD
    * ec2-import-instanceコマンドでOVF形式の仮想マシンをエクスポート
    * エクスポートは自動で変換が実行され、終了すると通常のEC2の操作と同様起動できるようになる
    * Windows VMをインポートするとWindows ServerライセンスキーがAWSによって用意される。そのため既存のWindowsライセンスはオンプレミス環境で使える
    * VMware vSphere Clientからインポートを行うこともできる(仮想アプライアンス

