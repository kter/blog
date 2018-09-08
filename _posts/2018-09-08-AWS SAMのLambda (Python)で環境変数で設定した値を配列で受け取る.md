---
id: 597
title: AWS SAMのLambda (Python)で環境変数で設定した値を配列で受け取る
date: 2018-09-08T16:28:02+09:00
author: kter
layout: post
image: 
categories:
  - AWS
tags:
  - AWS
  - lambda
  - Python
---
環境変数に設定された値は文字列としてしか取得できません。

なのでos.getenv()で値を取得したあとsplit()で配列化します。
ついでにstrip()も呼んでスペースも除去します。コードはこんな感じです。

```py
array = [x.strip() for x in str(os.getenv('(環境変数名)')).split(',')]
```

yamlファイルはこんな感じです。

```yaml
Resources:
  Lambda:
    Type: 'AWS::Serverless::Function'
    Properties:
      Handler: lambda_function.lambda_handler
      Runtime: python3.6
      CodeUri: .
      MemorySize: 128
      Role:
        Fn::GetAtt:
        - LambdaRole
        - Arn
      Timeout: 3
      Environment:
        Variables:
          (環境変数名): 'val1, val2, val3'
```

