---
id: 604
title: 'SlackにWebHookを送るときに+記号がスペースに置き換えられる問題の対応'
date: 2018-10-24T12:00:00+09:00
author: kter
layout: post
image: 
categories:
  - PHP
tags:
  - PHP
  - Slack
---
SlackにWebHookを送るときに+記号がスペースに置き換えられる問題の対応です。
この問題の解決に1,2時間掛かったのでメモしておきます…。

こんな感じでSlackにWebHookを送ろうと思っていたのですが、この例では+の部分がスペースに置き換わってしまいす。

```PHP
$params = [
    'title' => "タイトル",
    'text' => "プラス記号がスペースに置き換わる→+←",
    'channel' => $channel,
    'username' => $username,
    'icon_emoji' => $icon_emoji,
    'mrkdwn' => true,
    'attachments' => [$attachments]
];
$payload = 'payload=' . json_encode($params);
$ch = curl_init($webhook_url);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$result = curl_exec($ch);
```

バッククォートやダブルクォーテーションで括っても結果は同じ。
いろいろ試したり検索したりしていくうちにURLエンコードをすれば良いことに気が付きました。

ということでこのようにして解決。

```PHP
    'text' => urlencode("プラス記号がスペースに置き換わる→+←"),
```

後からよくよく調べてみるとドキュメントにちゃんとURLエンコードしろと書いてありました…
https://api.slack.com/docs/message-formatting

