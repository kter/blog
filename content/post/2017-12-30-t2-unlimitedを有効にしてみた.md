---
author: kter
categories:
- AWS
date: "2017-12-30T01:16:00Z"
id: 568
image: null
tags:
- AWS
title: T2 Unlimitedを有効にしてみた
---

T2インスタンスに対してT2 Unlimited機能を有効にしてみた。


## T2 Unlimited機能について

T2インスタンスはCPUクレジットを消費してCPU能力を上げるバーストという機能が使用できる。

このバーストはCPUクレジットを消費し尽くした場合は使えなくなってしまうが、消費し尽くした場合でもバーストし続けることができる機能をT2 Unlimitedと呼ぶ。


CPUクレジットの消費量は1vCPU毎1分間に1クレジットで、CPUクレジットの回復量と回復上限はインスタンスタイプごとに違う。<br />
具体的には下記ページの表にまとまっている。<br />
http://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/t2-instances.html

### バースト / T2 Unlimited詳細

CPUクレジットを消費し尽くした後T2 Unlimitedによりバーストが発生してもすぐには課金されない。

この場合CPUクレジットの回復上限の値までCPUクレジットを使って、初めて課金 (vCPU時間あたり0.05ドル)が発生する。


これらはそれぞれCPUSurplusCreditBalanceとCPUSurplusCreditsChargedというメトリクスで追跡できる。


つまり、バースト発生 → クレジットを使い切る → CPUSurplusCreditBalanceも上限 (CPUクレジットの回復上限の値) まで使い切る → 課金が発生という流れになる。


なおCPUSurplusCreditBalanceを使った場合では、CPUクレジットの回復にはまずCPUSurplusCreditBalanceの返済が必要で、返済が終わった段階からCPUクレジットの回復が始まる。

## 監視 (アラート)

何らかの問題によりバーストが発生し続けて、T2 Unlimitedの課金が気が付かれずに発生し続けることを避けるため、監視とアラートを設定する。


CloudWatchで設定を行い、アラートは課金が始まった時、つまりCPUSurplusCreditsChargedが0より大きくなった場合にアラートを送信するよう設定する。

## 設定

下記設定でT2 Unlimitedの設定と監視（アラート）の設定を行った。


アラート条件: CPUSurplusCreditsChargedが0より大きくなった時 (5分間隔1回連続)

アラート送信先: (既存SNSトピックを使用)


{{< highlight bash >}}
#!/bin/bash
set -euo pipefail

RET=$(aws ec2 describe-instances --query \
      'Reservations[].Instances[].{HostName:Tags[?Key==`Name`].Value|[0],InstanceId:InstanceId}' \
      --filters "Name=instance-type,Values=t2.*" --output text | awk '{ print $1","$2}' | sort | grep -v stg )

for LINES in $RET;
do
        INSTANCE_NAME=$(echo $LINES | awk -F, '{ print $1 }')
        INSTANCE_ID=$(echo $LINES | awk -F, '{ print $2 }')
        echo $INSTANCE_NAME

        aws ec2 modify-instance-credit-specification \
                --instance-credit-specification "[{\"InstanceId\": \"${INSTANCE_ID}\",\"CpuCredits\": \"unlimited\"}]"

        aws cloudwatch put-metric-alarm \
                --alarm-name "$INSTANCE_NAME でのT2 Unlimited課金発生" \
                --namespace AWS/EC2 \
                --metric-name CPUSurplusCreditsCharged \
                --dimensions "Name=InstanceId,Value=$INSTANCE_ID" \
                --period 300 \
                --statistic Average \
                --threshold 0 \
                --comparison-operator GreaterThanThreshold \
                --evaluation-periods 1 \
                --alarm-actions (既存SNSトピックを使用) \
                --ok-actions (既存SNSトピックを使用)
        echo "-----------"
done
{{< / highlight >}}


参考
https://aws.amazon.com/jp/blogs/news/new-t2-unlimited-going-beyond-the-burst-with-high-performance/

