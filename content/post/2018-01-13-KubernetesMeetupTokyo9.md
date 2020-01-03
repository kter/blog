---
author: kter
categories:
- 勉強会
date: "2018-01-13T13:56:00Z"
id: 572
image: null
tags:
- Kubernetes
- 勉強会
title: 'Kubernetes Meetup Tokyo #9 レポート'
---

内容の正当性は保証できません。こういう雰囲気でした。

## 概要

Kubernetes Meetup Tokyo #9

日時: 2018年1月12日19時から

URL: https://k8sjp.connpass.com/event/75328

## タイムテーブル

19:00-19:05 - Organizer & CyberAgent, Opening (5min)

19:05-19:20 - ianlewis, KubeCon Overview(15min)

19:25-19:40 - riywo, Review Adrian Cockroft’s keynote (15min)

19:45-20:00 - jyoshise, GPU, Deep Learning or Service mesh (15min)

20:05-20:20 - tnir, Kubernetes at GitHub (15min)

20:25-20:45 - CyberAgent Sponsor Session (20min)

## Review Adrian Cockroft’s keynote

@riywo

* AWSはCNCFに対してクレジットを補助したり、自社のサービスに取り入れたりと積極的にコントリビュートしている
* KubernetesのCNIのプラグインも作った
* ECSは繁盛している
* AWS Fargateをリリースした
    * LambdaのECS版的な
* Kuberentesをデプロイしているユーザーの68%はAWSにもデプロイしている
* HeptioとかがKubernetesをAWSで動かすためのインテグレーションを開発している
    * IAM連携とか
* AWS Fargate + Amazon EKSは2018年
    * フィードバックもよろしくね

## GPU, Deep Learning or Service mesh

@jyoshise

* ServiceMesh
    * マイクロサービス間をつなぐ
* Istio
    * 今アツいServiceMeshの実装
    * マイクロサービスでのカナリアテストがやりやすい
    * サービスごとにネットワークのポリシーを適用できる
* ML/DL on k8s
    * 機材が高価なのでk8sでスケジュールしてやる
    * ネットワークが問題
        * GPUノード間の通信がキツイ
    * やり方はいろいろある。
        * Microsoftはこれ用にCNIを作った

## Kubernetes at GitHub

@tnir 

* GitHubがK8sに移行
    * chatopsでnode追加
    * node設定はPuppetで
    * 1つのPodに3つのコンテナを入れている
        * Nginx, Unicorn, failbot(エラートラッキング)
        * Unix Socketを使用
    * cousul-service-router with haproxy (k8s以外のアプリへの通信？）
    * Node Portを使用。Ingressは使っていない
    * kubectl get系のコマンドはchatから使える
    * canary deployをannotationを使ってやっている
    * Persistent Volumeは分散システムを使用


## Deploying to Kubernetes Thouthand Deploys

* High Velocity重要 (こまめにリリースしよう）
    * リスク削減
    * コスト効率
        * コミットを貯めない
    * セキュリティ
        * 直ぐに脆弱性の対応等ができる
* Image First
    * Immutableなコンテナにする
        * local /dev / prdで同じイメージを
        * コンテナ実行時にプログラムをDLしない
        * localでビルドしない
* Shift Left
   * コードレビューはコスト高いので、テスト等を事前にやっておく
* Maintain Application Portability
    * クラスタが消し飛んだときに復旧できるか？
    * 設定ファイルはコンテナイメージに内包せず、ConfigMap / Secretを使う
        * Docker Buildはできるだけ避ける
    * Helm Chart化
        * 一括管理
    * DRのテスト
* Outsource Cluster Management
    * クラスタの管理は専門のチームに任せる
    * ただしスケーラビリティや冗長化を頭に入れて開発しておく
    * Certified Kubernetes Conformance Programに準拠した構成に使用
        * 一部のKubernetes環境にしかない機能は使わないようにしよう
* Connect all the dots
    * CodeFresh使うとか
        * Spinnaker + Concourse CI + DockerHub的なやつ
        * 設定をコード化できる

## Serverlessについて ~OpenFaaSの概要~

@徳田拓也

* OpenFaas
* FunctionWatchdog
    * リクエストのBodyを対象のSTDINに流す
* API Gateway /UIポータル
    * Prometheus経由でメトリクスを収集
* 同期処理 / 非同期処理 / 非同期処理+コールバック
* ```faas new --lang python sample``` でFunctionが作成される
    * Build後、Dockerイメージ化

