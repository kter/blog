---
author: kter
categories:
- AWS
date: "2018-09-30T12:00:00Z"
id: 602
image: null
tags:
- CloudFormation
- ECS
- CodePipeline
title: CloudFormationで作るCodePipelineで継続的デリバリされるECSクラスタを考えてみた
---
CloudFormationで作るCodePipelineで継続的デリバリされるECSクラスタを考えてみました。

# 前提

* リポジトリにはGitHubを使う
* CloudFormationで環境一式が作成される
* ECSは単一タスク定義にコンテナ2つ
    * WebとAppコンテナ
* CodepipelineはWeb, Appコンテナ用それぞれ用意

# コンポーネント

## GitHub

リポジトリを分けます。分ける理由はファイル更新時のデリバリー範囲を狭めるためです (Webコンテナの設定変更だけならAppコンテナは反映しない)。

* learning_of_codepipeline_ecs
    * CloudFormation設定ファイル
* learning_of_codepipeline_ecs_app
    * Appコンテナ用 Dockerfile
    * Appコンテナ用 Codebuild設定ファイル
* learning_of_codepipeline_ecs_web
    * Webコンテナ用 Dockerfile
    * Webコンテナ用 Codebuild設定ファイル

## CloudFormation

下記リソースの作成を行います。

* CodePipeline
* CodeBuild
    * App, WebコンテナイメージをビルドしてECRにPush
* ECSクラスタ
    * App, Webコンテナを動かす

## CodePipeline

単一PipelineでApp, WebコンテナのビルドとECSへのデプロイをやろうと思ったのですが、下記問題があったのでWebとAppで別のPipelineにしました。

* Web, Appどちらかの更新で両方のビルドが始まってしまう
* ECSへのデプロイ時に片方が常に失敗する

# 成果物

CodePipeline
https://github.com/kter/learning_of_codepipeline_ecs
Webコンテナ用
https://github.com/kter/learning_of_codepipeline_ecs_web
Appコンテナ用
https://github.com/kter/learning_of_codepipeline_ecs_app

# 備考

前述の通り、最初1つのPipelineでWeb, App両方のビルド & デプロイをしようと思ったのですが、リポジトリ更新時どちらもビルドが始まってしまう問題と、ECSのデプロイが失敗する問題で、最終的には2つに分けました。

