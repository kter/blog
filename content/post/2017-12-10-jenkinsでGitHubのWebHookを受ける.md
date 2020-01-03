---
author: kter
categories:
- Jenkins
date: "2017-12-10T19:55:47Z"
id: 561
image: /wp-content/uploads/2017/07/logo.png
tags:
- Jenkins
- GitHub
title: JenkinsでGitHubのWebHookを受ける
---

JenkinsでGitHubのWebhookを受けるのに手こずったので、手順を軽くメモ。

要点だけ軽くまとめます。

ポイントは認証トークンとAPIトークンをそれぞれ必要だということでした。

1. GitHub側の設定

    WebHookURLとして下記URLを指定する。

    ```
    https://ユーザ名:APIトークン（認証トークンではない)@JenkinsのURL/job/Job名/build?token=(認証トークン)
    ```

2. Jenkins側の設定

    認証トークンとAPIトークンを払い出す。

    認証トークンはプロジェクトの設定ページの"ビルド・トリガ"から任意の値を設定。

    APIトークンはユーザ情報の設定ページ(https://JenkinsのURL/user/(ユーザ名)/configure)から払い出す。

