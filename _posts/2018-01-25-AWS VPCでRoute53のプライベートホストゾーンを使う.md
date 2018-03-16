---
id: 573
title: AWS VPCでRoute53のプライベートホストゾーンを使う
date: 2018-1-25T11:50:00+09:00
author: kter
layout: post
image: 
categories:
  - AWS
tags:
  - AWS
  - Route53
  - VPC
---

# はじめに

VPCでのプライベートホストゾーンについて説明します。

これは```route53.test```のような実在しないドメインをRoute53に登録&設定すれば、設定したVPC限定でそのドメインが使えるというものです。

これを使って例えば次のようなことができます。

インスタンスAに```web.route53.test```というレコードセットをRoute53に登録

↓

設定したVPCのインスタンスからはwebという名前でインスタンスAにアクセスできる（どちらかと言うとリゾルバの機能ですが）

踏み台からのSSHやリレー、プロキシ先の指定などに便利ですよね。

# 料金について

[こちら](https://aws.amazon.com/jp/route53/pricing/)をご覧ください。月0.5ドルかかります。日割り計算はありません。

ただし作成から12時間は料金は発生しないようなので、テスト目的ならば12時間以内に削除しましょう。

# 設定

ドキュメントにいろいろ書かれていますが、大抵の場合次の手順でいけるはずです。

1. Route53でプライベートホストゾーンを登録
2. VPCのDNS, DHCP設定を変更

VPCのDHCPの設定を変更すれば```/etc/resolv.conf```の設定は自動で行われます。便利ですね。

## 1. Route53でプライベートホストゾーンを登録

Route53のページに行ってホストゾーンを作成します。

特に迷うことはないと思いますがこんな感じで

{% responsive_image path: assets/img/20180125/2018-01-25-01.png %}

次にレコードを登録しましょう。

登録するIPはもちろんプライベートIPアドレスで。

![]({{site.baseurl}}/assets/img/20180125/2018-01-25-02.png)

Route53での作業は以上です。

## 2. VPCのDHCP設定を変更

VPC一覧のページに移動し、DNSホスト名を```はい```に設定します。

![]({{site.baseurl}}/assets/img/20180125/2018-01-25-03.png)


次にVPCの```DHCP オプションセット```というページに移動します。

ここで予めオプションの値をメモしておいてください。

※多分こんな感じで設定がされていると思います。

```domain-name = ap-northeast-1.compute.internal;domain-name-servers = AmazonProvidedDNS;```

ドメイン名にメモした```domain-name```で指定されている値と**スペースを開けて**今回設定するプライベートホストゾーンの値を入力します。

ドメインネームサーバーには```AmazonProvidedDNS```と入力してください。

{% responsive_image path: assets/img/20180125/2018-01-25-04.png %}


最後にVCPの一覧画面に移動し、DHCPオプションセットの編集から、先ほど作成したオプションセットを指定します。

{% responsive_image path: assets/img/20180125/2018-01-25-05.png %}

5分程度待つと、設定したVPC内のインスタンスの```/etc/resolv.conf```が自動で変更され、instance01とinstance02でIPが引けるようになります。

![]({{site.baseurl}}/assets/img/20180125/2018-01-25-06.png)

※テストで作った場合は忘れずにホストゾーンを削除しましょう！

# 注意点

自分は試していないのですが、[ドキュメント](https://docs.aws.amazon.com/ja_jp/Route53/latest/DeveloperGuide/hosted-zones-private.html)に記載がある通り、名前空間が重複するパブリックゾーンとプライベートホストゾーンだと注意が必要です。

たとえばdevドメインのような実在するパブリックなドメインをプライベートホストゾーンに登録してしまうと、パブリックな方のDNSサーバには問い合わせてくれないということです。
気をつけましょう。


