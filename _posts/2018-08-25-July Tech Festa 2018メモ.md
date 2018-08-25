---
id: 595
title: July Tech Festa 2018メモ
date: 2018-08-25T15:01:02+09:00
author: kter
layout: post
image: 
categories:
  - 勉強会
tags:
  - July Tech Festa
  - 勉強会
---
自分用のメモですので悪しからず…

## Ansible with AWX ~ Move to the next step of IT automation ~

斉藤秀喜さん (twitter: saito_hideki)



* AWX(自動化プラットフォームでAnsible Towerのアップストリーム版)
    * Ansibleコマンドのラッパーとして動作する
    * ドキュメントはAnsible Towerの物を見れば良い（日本語版もある）
* 下記機能がある
    * WebUI / Restful API / Callback URL機能
    * ユーザ管理機能（Active Directory, Google OAuth2など）
    * ターゲットホストの認証情報を一点管理
    * AWS / GCP / Azure / OpenStackなどと連携可能
    * GitHub / Gitlabなどの外部SCM上のPlaybookを取得
    * 複数のジョブ（Playbook)をワークフローとして実行
        * 失敗したらこのジョブを動かすなどといった動作ができる
    * ジョブやワークフローを指定の日時で実行
    * ジョブの結果をIRCやSlackなどに送信
    * ログをlogstashやsplunkなど外部システムに転送
    * AWXサービスをクラスタ化（HAではなくマルチノード構成）
* dockerとpython-docker-pyが必要（Ansible Towerと違ってコンテナ上で動く）
* AWX自体のインストールもAnsible Playbookで行う

## 副業で収益化をめざす ~月数百円から始めるWebサービス立ち上げから運営まで~

高宮安仁さん

* 有給消化中で[Lingomine](https://lingomine.io/)という英語学習サービスを開発。

* 新規サービスは儲からない。儲かるまで耐える必要がある
    * →生き残るために支出を削る
    * 翻訳APIの結果をキャッシュ
* 安易に規模 (他人のリソース、お金等) を大きくしない
    * 収益が遠のく
* 一人で作る
    * 人的コストを最小に
    * 意思疎通ミスがない
    * 機能が増えない
        * →　運用・開発コストが減る
* シンプルにする
* 趣味を外れない。はじめのうちは趣味っぽくやる。
    * コストが圧縮される
* ほとんどの新規サービスは失敗する
    * →一度もリリースしないから
    * 自分用でいいから小さく進める
* 　リリースまでの秘訣
    *　毎日続ける
    *　小さなリリースを続ける
        *　次に何をすればいいのかが勝手に分かる
    * 問題を解決せずに避ける
        * コンテンツの追加をユーザーにやらせようとしたが、違反報告や音声アップロードなど、必要な機能が多くなることがわかったので、代わりにパブリックドメインなどのフリーのコンテンツを使うことにした。
* 他のサービスより少しだけ工夫する
    * それで十分競争力が持てる
* デフォルト至上主義
    * 余計な学習コストをかけない
* プログラミングを早く習得するには
    * Stack Overflowを使う
        * ほぼ100%答えが見つかる
    * Lintに教わる
        * RuboCop, Rails Best Practices, ESLint
        * 詳しい解説まで読むと超勉強になる
* すごい人になりきる
    * プログラミング、デザイン、宣伝、ユーザーサポート、規約作成など大変
    * 偉人は大変な時どう乗り切ったか調べてみてなりきる

## 明日から実践できる！ 運用自動化に必要なテストにまつわる技術

株式会社あくしゅ 山崎さん

* プログラムが本番でどう振る舞うか確認(テスト)しておく必要がある
    * 本番環境と同じ環境は用意できない
    * 環境が違う場合、特に運用のプログラムではテストにならない
* Terraform, CloudFormation等で本番環境と同じ環境を作成し、そこで動作確認を行う。
    * PaaSを使うと考えることが減らせる
    * マシンイメージを使う
        * 構築後の結果を担保する
    * 監視システムも環境に含める　

## 最高のITエンジニアリングを支える 守りと攻めの設計技術とSRE

北野 勝久さん (Twitter: katsuhisa__)

* 自己の事例と経験を踏まえてのよりよいサービスを提供するための筋道ややったことの紹介
    * うまく文章にまとまらず…

[https://speakerdeck.com/katsuhisa91/zui-gao-falseitenziniaringuwozhi-erushou-ritogong-mefalse-she-ji-ji-shu-to-sre](発表スライド)

## ミランティスが1万台のサーバーを監視・運用するためにInfrastructure as Codeを利用している話

星野 真知さん

* 運用している１万台のサーバを監視している
    * 極小数人で運用するためにCodeを使っている
* 構築時のパラメータはすべてGitを使っている
    * 変更はすべてSaltを使って行っている（自動化）
        * 運用も自動化できる
        * Word, Excelがいらない
        * 作業者感での品質差異が出にくい
        * 台数の増減に影響を受けない
* 公開できるコードはコミュニティに公開し、開発を委託
    * 各カスタマー固有のコードはカスタマーで管理してもらう
* Jenkinsを通じて毎日ビルド、テスト、配布が行われる
* Prometheusを使っている
    * 設定ファイルが細かい
    * エージェントのプラグインが大量
        * 設定ファイルをインフラコードの内容から自動生成
        * 構成から配布するエージェントを自動判別　 

## ソフトウェアで構築する成長し続けるインフラストラクチャとメルカリの挑戦

* メルカリのインフラの歴史紹介
* Consul
    * Service Discovery
        * DNSベースの内部LBとして利用
            * Solrによるキーワードサジェストで採用
    * Configuration deployment
    * Distributed Lock
        * キーワードサジェストのINDEXはDockerコンテナ内にある
        * 分散ロックで無停止INDEXアップデート
* OpenResty
    * NGINXをベースに作られたWeb Platform
    * Luaで機能を拡張
* 特定の商品への購入処理が集中しDBの負荷上昇
    * SELECT FOR UPDATEが数百滞留
    * Busy LockによりCPUの使用率が急上昇
    * DBへの問い合わせより前に並列度の調整
        * PHPでwaitを入れるとApacheのプロセスが枯渇する可能性
        * OpenRestyからMemcachedにadd（ロック）するようにする
* マイクロサービス化
    * 細かい単位でのスケーリング、障害の分離
    * サービス開発速度を上げる
    * 1000名以上のエンジニアでも対応できるようにする
    * API Gatewayを全面に置き、配下のサービスを変えていった
* Kubernetes
    * 運用負荷を減らすために使用
* Spinnaker
    * デプロイに使用
* Terraform
    * サービスをすばやく立ち上げるために使用
* 石狩, 東京間のレスポンス改善
    * 3 way handshakeを避ける。TLSのhandshakeも避ける
    * HTTP/1, HTTP/2のKeepAliveを活用する
        * PHPではリクエス間のHTTPコネクションの再利用ができない
        * choconというソフトを作成し改善
            * Consulで冗長化している

