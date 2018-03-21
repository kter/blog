---
id: 580
title: CodeBuildを使ってみたメモ
date: 2018-03-21T11:56:00+09:00
author: kter
layout: post
image: 
categories:
  - AWS
tags:
  - AWS
  - CodeBuild
---
本当に今更だけどCodeBuildを使って、GitHubリポジトリのDockerfileをビルド&イメージプッシュ & Kubernetesにデプロイする設定を入れたので知見をメモする。

### GitHubと連携できる

てっきりリポジトリにコミットされたらCodeBuildを実行〜みたいな時、CodeCommitじゃないとできないのかなと思っていたのですが、GitHubでもできました。

### CodeBuildでDockerイメージをビルド(dockerコマンドの実行)する際には、CodeBuildオリジナルのDockerイメージを使わなければならない

"特権付与"にチェックを入れても、CodeBuild用のaws/codebuild/dockerイメージでなければdockerコマンドは使えません。

### CodeBuildコンテナでのRubyインストール方法

前述の理由によりRubyを使いたい時、Rubyイメージが使えずコンテナにRubyをインストールするしかないのですが、普通にapt-get install rubyだと1.9が入ってしまいます。

2.4等新しいものをインストールする場合は次のようにします。

```bash
apt-get install -y software-properties-common
apt-add-repository -y ppa:brightbox/ruby-ng
apt-get update -y
apt-get -y install ruby2.4 ruby2.4-dev
```

### イメージのタグなどに使う用のGitコミットID取得方法

下記変数が自動的にセットされているので、これが使えます。

※CodeBuild上のファイルは.gitがないようです。

```
CODEBUILD_RESOLVED_SOURCE_VERSION
```

### シークレットの取り扱い

CodeBuildで環境変数を設定できるが、パスワード等のシークレットはAWS Systems Managerのパラメータストアを使います。

下記例は、パラメータストアにvalという名前で登録した値を、CodeBuild内でkeyという環境変数名前で使用できます。

```yaml
env:
  parameter-store:
    key: "val"
```

