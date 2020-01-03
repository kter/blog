---
author: kter
categories:
- AWS
date: "2018-05-23T21:48:00Z"
id: 585
image: null
tags:
- AWS
- Elastic Load Balancing
- ELB
title: 自分用AWS クラウドサービス活用資料集メモ Elastic Load Balancing編
---
# AWS クラウドサービス活用資料集メモ

## サービス別資料

### コンピューティング

#### [Elastic Load Balancing (ELB)](https://aws.amazon.com/jp/elasticloadbalancing/)

情報元: [AWS Black Belt Online Seminar 2016 Elastic Load Balancing](https://www.slideshare.net/AmazonWebServicesJapan/aws-black-belt-online-seminar-2016-elastic-load-balancing)

* Application Load Balancer
    * L7のコンテントベースのロードバランサー
    * ターゲットグループに対してルーティング
    * コンテナベースのアプリケーションのサポート
    * WebSocketとHTTP/2のサポート
    * 複数のAZで耐障害性が高い
    * 価格はALBの起動時間とLoad Balancer Capacity Units(LCU)の使用量で決まる
* Elastic Load Balancing (ELB)
    * Application Load BalancerとClassic Load Balancerの二種類がある。
        * Application Load BalancerはL7のコンテントベースのロードバランサー
        * Classic Load BalancerはL4および一部L7機能を提供するロードバランサー
* ELBは複数AZに設定できる。DNSラウンドロビンで各AZのELBにアクセスが分散される。その後負荷が均等になるようバックエンドのEC2に振り分けられる
* クロスゾーン負荷分散を使うことで、AZ間のキャパシティ（インスタンス数、サイズ）が異なる場合やクライアントがDNSをキャッシュする環境でも負荷を均等にできる。
* 無通信状態が続くとそのコネクションを自動で切断する。デフォルトでは60秒、最低1秒最高3600秒
* ELBは自動でスケールするが、瞬間的に急増すると503を返す。
    * Pre-Warming（暖機運転）の申請を行うあ負荷を段階的にかける
    * ただしPre-WarmingはBusiness/Enterpriseサポートが必要
* サブネットは最小/27、空きIPは8以上
* ICMP Echo Request/Replyを許可すれば、ELBがpingにも応答する
* Perfect Forward Secrecyのサポート
* Server Order Preference対応
* スティッキーセッション
    * 同じユーザから来たリクエストをすべて同じEC2インスタンスに送信
    * ELBで生成するCookieかアプリケーションで生成するCookieか選べる
* Connection Draining
    * ELBから登録解除したりヘルスチェックが失敗したときに、新規割り振りは中止して処理中のリクエストが終わるまで一定期間末
* CLBはTCP/SSLによる負荷分散が可能
* CLBはバックエンドインスタンスのサーバ証明書認証ができる
* CLBのコンテントベースルーティングはサブドメインかNGINXで行う。
* Load Balancer Capacity Unitsは新規接続数、アクティブ接続数、帯域幅のうち、最も使用量が高いディメンションのみ請求
    * 新規接続数: 1秒あたりの新規接続数
    * アクティブ接続数: 1分あたりのアクティブ接続数
    * トラフィック量（Mbps)
* 1 LCUには1秒あたり最大25の新規接続数 (4KB証明書の場合は最大5), 1分あたり最大3000個のアクティブ接続, 最大2.22Mbpsの帯域幅が含まれている
* Route53 DNS フェイルオーバー対応 (Route53のヘルスチェックに失敗するとS3のSorryページにアクセスさせるようにできる)
* 負荷テスト時の注意事項
    * ELB暖機運転
    * 5分間隔で50%以上のトラフィック増加をしないよう負荷テストを設定
    * テストクライアント側で少なくとも1分に1回DNSの再解決をする
    * スティッキーセッションに注意
    * **バックエンドインスタンスのアイドルタイムアウトをELBのタイムアウト以上**に設定しないと不健全なホストとみなされる可能性がある

#### [Elastic Load Balancing] ロードバランサと Socket 接続を使用したイベント通知サーバの負荷分散

情報元: [WebSocket on AWS (ロードバランサとSocket接続を使用したイベント通知サーバの負荷分散)](https://www.slideshare.net/AmazonWebServicesJapan/socket-15753751)

* WebSocketはセッションごとTCPセッションが作成され、セッション中破継続的に利用する。
    * そのため間にLBを挟むとLBのコネクションも専有し、LBのリソースがボトルネックになる
    * WebSocketはサーバーとクライアントを1対1でセションを確立させそれを維持する仕組みなのでLBはあまり意味がない
    * →セッション確立時の時のみLBを使うのがいい
        * LBにGETし、Responseとしてアプリサーバのアドレスを返す
        * クライアント側で再接続の仕組みも必要

#### [Elastic Load Balancing] ELBを評価するためのベストプラクティス

情報元: [Elastic Load Balancing(ELB)を評価するためのベストプラクティス](http://d36cz9buwru1tt.cloudfront.net/jp/documentation/BestPracticesInEvaluatingELB-ja-final.pdf)

* 負荷テストの際にはDNSの名前解決について留意する
    * ELBがスケールする際にIPアドレスが増えるため
    * 少なくとも1分に1回名前の再解決を行うようにする
* 負荷の増やし方は5分おきに50%未満のレートで負荷を増やすことが推奨される
* メトリクスは次の通り
    * 遅延時間
    * リクエスト数
    * 健全なホスト数
    * 不健全なホスト数
    * バックエンドからの 2xx-5xx のレスポンス数
    * ELB からの 4xx-5xx のレスポンス数
* インスタンスのアイドルタイムアウトは少なくとも60秒に設定する
    * ELBは60秒後にアイドルコネクションをクローズするため

