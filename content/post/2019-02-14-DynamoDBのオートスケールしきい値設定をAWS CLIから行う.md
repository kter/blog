---
author: kter
categories:
- AWS
date: "2019-02-14T12:00:00Z"
id: 611
image: null
tags:
- AWS
- awscli
title: DynamoDBのオートスケールしきい値設定をAWS CLIから行う
---
DynamoDBのオートスケール設定をAWS CLIから行う

今までブラウザのAWSコンソールからポチポチやっていましたが、必要になったので調べました。
オートスケール設定はDynamoDBではなくapplication-autoscaling経由で行うようです。

DynamoDBテーブルの確認

```bash
aws application-autoscaling describe-scaling-policies --service-namespace dynamodb --resource-id "table/テーブル名"
```

オートスケールしきい値設定

```bash
aws application-autoscaling put-scaling-policy --service-namespace dynamodb --policy-name "DynamoDBReadCapacityUtilization:table/テーブル名"  --resource-id "table/テーブル名" --scalable-dimension dynamodb:table:ReadCapacityUnits --policy-type TargetTrackingScaling --target-tracking-scaling-policy-configuration '{ "TargetValue": リードの値, "PredefinedMetricSpecification": { "PredefinedMetricType": "DynamoDBReadCapacityUtilization" } }'
aws application-autoscaling put-scaling-policy --service-namespace dynamodb --policy-name "DynamoDBWriteCapacityUtilization:table/テーブル名"  --resource-id "table/テーブル名" --scalable-dimension dynamodb:table:WriteCapacityUnits --policy-type TargetTrackingScaling --target-tracking-scaling-policy-configuration '{ "TargetValue": ライトの値, "PredefinedMetricSpecification": { "PredefinedMetricType": "DynamoDBWriteCapacityUtilization" } }'
```

