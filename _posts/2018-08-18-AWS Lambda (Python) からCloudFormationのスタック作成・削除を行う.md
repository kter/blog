---
id: 593
title: AWS Lambda (Python) からCloudFormationのスタック作成・削除を行う
date: 2018-08-18T15:08:02+09:00
author: kter
layout: post
image: 
categories:
  - AWS
tags:
  - AWSLambda
  - CloudFormation
  - Python
  - python3 
---

業務時間だけ使うAWSリソースがあり、それをCloudFormationを使って管理しているという場合、Lambdaからスタックの作製・削除ができると便利です。

削除するのは簡単なのですが、作成するときは少し手こずったのでそれを書いておきます。

### 作成

TemplateURLにS3バケット内のファイルを指定する場合は次のようにします。
※httpsとスキームが付きますが、Webホスティングの設定は必要ありません。

```
https://s3-ap-northeast-1.amazonaws.com/(S3バケット名)/ファイル名
```

ということで作成するときはこんな感じになります。

```py
    cf = boto3.client('cloudformation')
    res = cf.create_stack(
        StackName=(スタック名),
        TemplateURL='https://s3-ap-northeast-1.amazonaws.com/(S3バケット名)/ファイル名',
        Parameters=[
            {
                'ParameterKey': 'パラメータ名1',
                'ParameterValue': '設定値1'
            },
            {
                'ParameterKey': 'パラメータ名2',
                'ParameterValue': '設定値2'
            },
        ],
        Capabilities=[
            'CAPABILITY_NAMED_IAM',
        ],
    )
```

### 削除

削除はスタック名を指定するだけなのでとても簡単。

```py
    cf = boto3.client('cloudformation')
    res = cf.delete_stack(
        StackName=(スタック名)
    )
```

