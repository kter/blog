---
id: 575
title: "GKEでなるべく安くKubernetesクラスタを作成してPrometheus + Grafanaを使ってみる Part1 -クラスタ作成編-"
date: 2018-02-11T11:38:00+09:00
author: kter
layout: post
image: 
categories:
  - Kubernetes
tags:
  - GKE
  - Kubernetes
  - Prometheus
  - Grafana
---

タイトルの通りGKE (Google Kubernetes Engine)でKubernetesクラスタを作成して、その上でPrometheusとGrafanaを動かしてみます。

まずはGKEでKubernetesクラスタを作成してみます。

# はじめに

GCP(Google Cloud Platform)アカウントの登録とプロジェクトの作成が終わってる前提でお話します。

適当に作っておいてください。

# クラスタの作成

左上のハンバーガーメニューからKubernetes Engineを選択

※初回アクセス時には準備に数分かかります。

クラスタの作成ボタンを押下します。

{% responsive_image path: assets/img/20180211/2018-02-11-01.png %}

## 設定

今回のように可用性 (ダウンタイム)に目をつぶるならノードにプリエンプティブを使うことで、[インスタンスの費用](https://cloud.google.com/compute/pricing?hl=ja#machinetype)を7割程度抑えることが出来ます (オレゴン、g1-smallの場合)。

※[プリエンプティブ](https://cloud.google.com/preemptible-vms/?hl=ja)にした場合、２４時間以内に勝手に落とされてしまうので気をつけてください。

ノードは価格の安い海外のリージョンを使い、マシンタイプはsmallを使います。

またデフォルトでは、ノードのディスクサイズが100GBという罠があるので、忘れずに減らしておきましょう。

  1. ゾーン: us-west1-b
  2. マシンタイプ: small（g1-small)
  2. 自動スケーリング: オン
  3. 最大サイズ: 6
  4. プリエンプティブ ノード: 有効
  5. ノードあたりのブートディスク サイズ: 10GB
  6. HTTP 負荷分散: 無効

## 接続

クラスタの作成が終わったらkubectlコマンドでクラスタに接続してみます。

接続ボタンを押下し、"Cloud Shellで実行"を押下します。

{% responsive_image path: assets/img/20180211/2018-02-11-02.png %}

ウインドウ下部に、コマンドが入力済みの状態でコンソールが表示されます。
Enterキーを押してコマンドを実行します。

これでkubectlでアクセスできるようになりました。

```kubectl get nodes```を実行して作成したノードが表示されるかどうか確認します。

以上

