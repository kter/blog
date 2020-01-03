---
author: kter
categories:
- Kubernetes
date: "2018-03-10T13:09:00Z"
id: 578
image: null
tags:
- Kubernetes
title: 'Kubernetes Meetup Tokyo #10レポート'
---
内容の正当性は保証できません。こういう雰囲気でした。

スライドとか公開されたら更新します。

## 概要

Kubernetes Meetup Tokyo #10
日時: 2018年3月8日19時から
URL: https://k8sjp.connpass.com/event/76816/

## Open Service Broker APIとKubernetes Service Catalog

by Toshiaki Maki (@making) (Pivotal)

データベースをどこにだれが作成していますか？

よくある例: 開発者がDBが必要な時にDBAに依頼 (DB作成、ユーザ作成)。

Service Brokerを使えば、DBの作成・構築・設定まで自動で行える。

Service Brokerを使うにはOpen Service Broker APIを使う。
これはもともとはCloud Foundryのサービスだった。

KubernetesではService Catalogを経由してService Brokerを使う。

Service Brokerによって作成される機密情報はSecretに入れてくれる・

helmでインストールできる。

ブローカーが構築済みであれば、開発者は下記手順を踏むことでリソース(DB等)を用意できる。

1. ServiceInstance作成 -> リソース（DB等）が作成される
2. ServiceBinding作成 -> パスワード等がシークレットにセットされる

## Kubernetesセキュリティベストプラクティス

by Ian Lewis (Google)

Guestbookアプリを例にベストプラクティスを紹介。

* フロントはHTML/CSS/JS
* メッセージが保存・閲覧できる
* NGワード検出機能がある
* よくあるマイクロサービス

### Kubernetes API Serverについて

#### シナリオ: フロントエンドPodからトークン取得、APIサーバを攻撃、シークレットを取得しさらに攻撃

Podにはトークンがマウントされているので、Podに侵入されるとトークンが抜かれるおそれがある。
トークンを使ってAPIサーバにアクセスすればシークレット（パスワード等)が抜かれる。

#### 改善策1: RBACを使おう

例えばWebサーバはAPIサーバにアクセスする必要が無いので、アクセス出来ないようRBACを設定する。
GKEだとIAMと連携でき、管理が楽。

#### 改善策2: APIサーバにファイアウォールを設定しよう

APIサーバへのアクセスをIPアドレスに制限
```gcloud container clusters create --enable-master-authorized-networks --master-authorized-networks=...```
https://cloud.google.com/sdk/gcloud/reference/container/clusters/create

#### 改善策3: ネットワークポリシーを設定しよう

データベースへのアクセスを必要なPodに制限したりする。
networkpolicyのpodSelectorを使う。iptablesが設定される。

### ホストについて

#### シナリオ: コンテナを突破され、ホスト上で色々される。

Podはサンドボックスで実行されるのでrootで動いていても通常問題ないが、コンテナを突破されるとホストにrootで入られてしまう。

#### 改善策1: non-rootで実行

podのrunAsUserを使う。

#### 改善策2: 読み込み専用ファイルシステム

podのreadOnlyRootFilesystemを使う。

#### 改善策3: no_new_privs

podのallowPrivilegeEscalationを使う。
コンテナを実行する時、フォークする時自分以上の権限を与えない。

#### その他改善策:

seccomp, AppArmor, SELinuxを使う。または組み合わせる。

おすすめはruntimeのdefaultを使う。

#### その他改善策2: kubeletの権限を制限する

できるだけkubeletに必要な権限だけ与える。

```
--authorization-node=RBAC,Node
--admission-control=...,NodeRestriction
```

kubeletの証明書をローテーションする
```kublet... --rotate-certificates```

短い期間でローテーションすれば盗まれても有効期間が限られる。

### Unsecured Pods

#### シナリオ: 同じクラスタ内にセキュリティが甘いPodがある場合がある。そこから色々されてしまう。

#### 改善策1: PodSecurityPolicyを使う

### トラフィック傍受

#### シナリオ: ネットワークトラフィクを傍受され、サービス拒否攻撃等をされる。

#### 改善策1: istioを使う

* サービス間のプロキシ
* 暗号化
* 証明書の自動更新
* ポリシーの集中管理

## Debugging Applications in Kubernetes

by Takashi Kusumi (Z Lab)

### 問題点

* PodやServiceにクラスタ外からアクセスできない（負荷試験など）
* コンテナにデバッグツールがはいってない（tcpdumpとか)

### kubectlでの基本

使えるサブコマンド

* run
    * -itでインタラクティブに操作できる
    * クラスタ内からPodやServiceにアクセスしたい時に最適
    * --rmと--restart=Neverをつけよう
    * --serviceaccountオプションを使うとServiceAccount権限周りのデバッグに便利。この時googlのhyperkubeイメージを使うと便利。
    * --overridesオプションを使うと、JSONの上書きができる。runでは設定できないフィールドも設定できる。
* logs
    * --sinceで時間を指定できる
    * --timestampでタイムスタンプを表示できる
    * wercker/sternというツールを使うと複数のログを一度に見れて便利
* exec
    * コンテナ内で任意のコマンドを実行
* port-forward
    * ポートフォワード
    * ローカルにListenしてるものにも使える
* cp
* top
    * ノードとPodのCPU/メモリ使用率がわかる

### PodとLinux名前空間

Podで共有されるのは

* IPC
    * シグナルとか送れる
    * pauseというコンテナが共有する舐め空間を保持している
    * scratchのイメージだとシェル入ってない
        * /proc/[pid]/rootでそのPIDがマウントしているルートがみれる
        * kubectl get podsしてノードを確認
        * --overridesでdockerを起動
        * docker run --pidを使う
        * 
        * マウントしているディレクトリを覗ける
     * scratch-debuggerツールを使う
* Network

### 今後使える新機能

Debug Containers
kubectl debugでデバッグコンテナが使える

## LT 『入門Kubernetes』の紹介

by @dblmkt

自身が翻訳した入門Kubernetesの書籍の紹介。
トピックとしては1.9までの情報を追加している。

## LT 猫でもわかる Pod Preemption
by @y_taka_23

Podをノードに振り分ける時、キャパシティ不足になった。

* Priorityを高いものを配置する時、低いものを落として高いものを配置する

意義について　

* 今までは積極的にPodを追い出す方法がなかった。
* ノードがスケールしない環境がある。
* ノードのスケールには時間がかかる
* コストが予測可能になる

仕組み

* 配置しようとするPodのプライオリティより低い物を選ぶ
* Nodeに順位付けして配置

ただしAffinityの指定が問題になるので、注意する。

## LT Amazon Container Services
by @riywo

Amazon Container Servicesの信条

1. エンタープライズのワークロードを動かす
2. UpstreamのK8s
3. AWSサービスとの連携
4. コントリビュート

他AWSサービスと連携できる。

例えば

* kubectlのクレデンシャルにIAMが使える
* EFSをPersistentVolumeで使える
* IngressでALBで使える。Route53連携もできる。

## LT other ingress voyager
by @gavinzhm

voyagerはAppCodeが開発しているIngress

* Ingressが一つで済む
* Lets Encryptが使いやすい
* ワイルドカード証明書対応
* ネームスペース超えができる
* ドキュメントクオリティーが高い
* issue対応が早い (5分でレスポンスが帰ってきたことも)
* …等

## LT DockerでHelmを使おう
by @ShoutaYoshikai

ローカル / 開発でHelmを使うと色々便利
しかしhelmでは設定できない項目があったりする。

helmみんなも使っていこうぜ。



