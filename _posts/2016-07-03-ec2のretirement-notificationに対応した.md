---
id: 207
title: EC2のRetirement Notificationに対応した
date: 2016-07-03T13:10:55+00:00
author: kter
layout: post
#guid: https://blog.kter.jp/?p=207
#permalink: /?p=207
categories:
  - AWS
tags:
  - EBS
  - Retirement Notification
  - メンテナンス
---
EC2のRetirement Notificationが来ていたので対応しました。

メールでの対応方法では次のように来ていて、つまりAMIからインスタンスを作りなおせと書いてありました。

> You may still be able to access the instance. We recommend that you replace the instance by creating an AMI of your instance and launch a new instance from the AMI. For more information please see Amazon Machine Images (<a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html" target="_blank" rel="noreferrer" data-saferedirecturl="https://www.google.com/url?hl=ja&q=http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html&source=gmail&ust=1467603295142000&usg=AFQjCNGWK8bb2yxq4LibDJP0zuy4YnfbzA">http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html</a>) in the EC2 User Guide. In case of difficulties stopping your EBS-backed instance, please see the Instance FAQ (<a href="http://aws.amazon.com/instance-help/#ebs-stuck-stopping" target="_blank" rel="noreferrer" data-saferedirecturl="https://www.google.com/url?hl=ja&q=http://aws.amazon.com/instance-help/%23ebs-stuck-stopping&source=gmail&ust=1467603295143000&usg=AFQjCNHK_DApdxBLUp-WgRojronZG8kIiQ">http://aws.amazon.com/instance-help/#ebs-stuck-stopping</a>).

実際にはインスタンスを停止してから起動するだけで大丈夫でした。

[<img class="alignleft wp-image-212 size-full" src="https://blog.kter.jp/wp-content/uploads/2016/07/ebs_retirement_notif2.jpg" alt="ebs_retirement_notif2" width="548" height="218" srcset="https://kter.jp/wp-content/uploads/2016/07/ebs_retirement_notif2.jpg 548w, https://kter.jp/wp-content/uploads/2016/07/ebs_retirement_notif2-300x119.jpg 300w" sizes="(max-width: 548px) 100vw, 548px" />](https://blog.kter.jp/wp-content/uploads/2016/07/ebs_retirement_notif2.jpg)

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

&nbsp;

[<img class="alignleft wp-image-211 size-full" src="https://blog.kter.jp/wp-content/uploads/2016/07/ebs_retirement_notif1.jpg" alt="ebs_retirement_notif1" width="985" height="189" srcset="https://kter.jp/wp-content/uploads/2016/07/ebs_retirement_notif1.jpg 985w, https://kter.jp/wp-content/uploads/2016/07/ebs_retirement_notif1-300x58.jpg 300w, https://kter.jp/wp-content/uploads/2016/07/ebs_retirement_notif1-768x147.jpg 768w" sizes="(max-width: 985px) 100vw, 985px" />](https://blog.kter.jp/wp-content/uploads/2016/07/ebs_retirement_notif1.jpg)