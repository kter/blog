---
author: kter
categories:
- AWS
date: "2018-10-25T12:00:00Z"
id: 605
image: null
tags:
- YAML
- CloudFormation
title: CloudFormationでSecurityGroupを作るときにYou may not define rules between a VPC group
  and a non-VPC groupとエラーが出るときの対応
---
CloudFormationでSecurityGroupを作るときにYou may not define rules between a VPC group and a non-VPC groupとエラーが出るときの対応

解決まで地味に30分程度掛かったのでメモ。

CloudFormationで次のような感じでSecurityGroupを作ろうとすると、`You may not define rules between a VPC group and a non-VPC group`とエラーが出てSecurityGroupが作れない。

```yaml
  DBEC2SecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      GroupDescription: "Allow access from specific SecurityGroup"
      SecurityGroupIngress:
      - IpProtocol: tcp
        FromPort: '3306'
        ToPort: '3306'
        SourceSecurityGroupId: !Ref 'EC2SecurityGroup'
```

これはSourceSecurityGroupにVPCのSecurityGroupが指定されているのに、（VpcIdが指定されていないため）EC2 Classic環境にSecurityGroupが作られようとしているため出たエラーである（言葉にするとややこしい）。

[ドキュメント](https://docs.aws.amazon.com/ja_jp/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group.html#cfn-ec2-securitygroup-vpcid)にもあるが正しくはこんな感じ。

```yaml
  DBEC2SecurityGroup:
    Type: AWS::EC2::SecurityGroup
    Properties:
      VpcId: !Ref VPC
      GroupDescription: "Allow access from specific SecurityGroup"
      SecurityGroupIngress:
      - IpProtocol: tcp
        FromPort: '3306'
        ToPort: '3306'
        SourceSecurityGroupId: !Ref 'EC2SecurityGroup'
```

ドキュメントは見ていたけど眠かったのとエラーメッセージに惑わされて解決まで時間掛かってしまった…。

