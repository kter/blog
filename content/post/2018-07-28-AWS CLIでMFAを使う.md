---
author: kter
categories:
- AWS
date: "2018-07-28T15:15:00Z"
id: 592
image: null
tags:
- AWS CLI
- MFA
title: AWS CLIでMFAを使う
---
MFA設定後、AWS CLIからMFAを使うためには一時的なクレデンシャルを発行する必要があります。

## 前提

IAMポリシーにこんな感じでConditionを設定するとMFAが有効になっていない時の設定を行うことができます。

ここで例えばEffectをDenyに、Actionをiam:DeleteUserとすると、MFA認証なしではDeleteUserができなくなります。

```js
            "Condition": {
                "Bool": {
                    "aws:MultiFactorAuthPresent": "false"
                }
            }
```

MFAを設定しておけば、AWSマネジメントコンソールにログインしようとするとMFAのコード入力画面が勝手に出てきますが、AWS CLIの場合は出てきません。

## 本題

どうするのかというと次のコマンドを実行し、一時的なクレデンシャルを発行します。

```bash

aws sts get-session-token --serial-number (登録MFAのARN 例：arn:aws:iam::500000000:mfa/kter) --token-code (MFAコード)
```

環境変数にクレデンシャルを突っ込むワンライナーはこちら。

```bash
eval `aws sts get-session-token --serial-number (登録MFAのARN) --token-code (MFAコード) | awk ' $1 == "\"AccessKeyId\":" { gsub(/\"/,""); gsub(/,/,""); print "export AWS_ACCESS_KEY_ID="$2 } $1 == "\"SecretAccessKey\":" { gsub(/\"/,""); gsub(/,/,""); print "export AWS_SECRET_ACCESS_KEY="$2 } $1 == "\"SessionToken\":" { gsub(/\"/,""); gsub(/,/,""); print "export AWS_SESSION_TOKEN="$2 } '`
```

### 参考にさせていただいたページ

https://www.slideshare.net/tetsunorinishizawa/aws-cliassume-role


