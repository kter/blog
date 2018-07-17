---
id: 590
title: Lambda (Python) から特定のログストリームにログを書こうとして苦戦した2つのポイント
date: 2018-07-17T22:48:00+09:00
author: kter
layout: post
image: 
categories:
  - AWS
tags:
  - Lambda
  - AWS
  - Python
  - CloudWatch Logs
---

Lambda (Python) から指定のログストリームにログを書こうとして苦戦したのでメモ。

今日使い始めたばかりなので間違ってる点があるかもしれません。もし間違っていたら教えてくださいm(_ _)m

# 苦戦ポイント1 -put_log_events()の使い方-

結論から言って次のようにする必要があります。

```py

      logs_client = boto3.client('logs')

      res = logs_client.describe_log_streams(
          logGroupName='(ロググループ名)',
          logStreamNamePrefix='(ログストリーム名)',
      )
      seq_token = res['logStreams'][0]['uploadSequenceToken']

      res = logs_client.put_log_events(
          logGroupName='(ロググループ名)',
          logStreamName='(ログストリーム名)',
          logEvents=[
              {
                  'timestamp': int(time.time()) * 1000,
                  'message': '%s backed up successfully' % (message)
              },
          ],
          sequenceToken=seq_token
      )
```

注意する点が2点ほどあります。

### timestampの指定
まず1点目、timestampはUNIX時間に1000を掛けたものを**整数**で指定しましょう。つまり単位が**ミリ秒**です。

### sequenceToken
2点目、ログを書き出すput_log_events()にはsequenceTokenというパラメータが必要になります。
ログストリームへの初回の書き込みなら（多分）いらないのですが、2回目以降は必要になります。

上記コードではsequenceTokenをdescribe_log_streams()から取得していますが、put_log_events()のレスポンスの中にもありますのでそれを使ってもいいです。

# 苦戦ポイント2 -IAM ポリシー-

結論から言って次のようにする必要があります。

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
            ],
            "Resource": [
                "arn:aws:logs:*:*:/aws/lambda/(Lambda関数名☆ワイルドカード可☆)",
                "arn:aws:logs:*:*:log-group:(ロググループ名):log-stream:(ログストリーム名)"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "logs:DescribeLogStreams"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ],
            "Effect": "Allow"
        }
    ]
}
```

ポリシーについて先に説明させていただきますと、最初のCreateLogGroup, CreateLogStream, PutLogEventsはCloudWatch Logsにログを書き出す（ログストリームの作成も）時に必要です。

最初のResource内の1つ目　（```"arn:aws:logs:*:*:/aws/lambda/(Lambda関数名☆ワイルドカード可☆)"```）は、Lambdaからprint()やloggerを使った時、自動でCloudWatch Logsに送られるのでその時用です。

その上での注意する点はResourceの指定です。

### Resource指定

最初のResource内の2つ目（```arn:aws:logs:*:*:log-group:(ロググループ名):log-stream:(ログストリーム名)```）は今回の問題である特定のログストリームに書くときのArn指定です。
自分は最初間違えて```arn:aws:logs:*:*:(ロググループ名)/(ログストリーム名)```とかやってました。

前述のdescribe_log_streamsのためにlogs:DescribeLogStreamsをarn:aws:logs:*:*:*に対して設定するのも忘れないでください。

