---
id: 457
title: Route53をGitで管理するようにした
date: 2017-08-11T09:03:57+00:00
author: kter
layout: post
#guid: https://kter.jp/?p=457
#permalink: /?p=457
categories:
  - AWS
tags:
  - AWS
  - Route53
---
Route53のレコード管理は困難を極める。
  
いつの間にかレコードが増えてきて、後から消そうと思っても用途などが思い出せず消すに消せない…そんなレコードが増える経験をした。

Route53をGitで管理するようにすればPRによる第三者のレビューがやりやすいし、何より誰がいつどんな用途でレコードを追加・変更・削除したのかが丸分かりである。

ここではroadworkerというナイスなRuby製のGemを使った。
  
https://github.com/codenize-tools/roadworker

使い方は上記リポジトリもあるが、基本的には次の通り。

  1. 現在のRoute53登録情報をファイルにする (初回のみ) <pre class="lang:default decode:true">roadwork -e -o Routefile</pre>

  2. ファイルを編集する
  3. 確認のためにdry-runする <pre class="lang:default decode:true">roadwork -a --dry-run</pre>

  4. Route53に反映 <pre class="lang:default decode:true ">roadwork -a</pre>

  5. 反映確認 <pre class="lang:default decode:true">roadwork -t
</pre>

&nbsp;

これでRoute53の管理が楽になった。
  
次はGitHubにファイルをプッシュするとCIツールによってRoute53に自動的に反映させるようにしたい。

8/20追記
  
Jenkinsで自動反映するようにした。
  
GitHubのWebHookをJenkinsで受けて、roadworkを実行。進捗はJenkinsの[Slackプラグイン](http://qiita.com/unsoluble_sugar/items/a42795d108624fcd02d4)を使った。