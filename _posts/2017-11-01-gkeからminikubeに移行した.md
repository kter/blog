---
id: 552
title: GKEからminikubeに移行した
date: 2017-11-01T01:08:47+00:00
author: kter
layout: post
#guid: https://kter.jp/?p=552
#permalink: /?p=552
image: /wp-content/uploads/2017/11/logo.png
categories:
  - Docker
  - GCP
  - Kubernetes
tags:
  - Kubernetes
  - minikube
---
GKEがとにかく高い。
  
ロードバランサーとn1-standard-1 (だったかな？)2つで月5, 6千円はかかっていた。

いままでは3万円分くらいのクレジットを使って実質無料で運用できていたけど、それも尽きそうだったので月1000円 メモリ2GBのVPSでminikubeを使って運用することにした。

移行はそこまで大変ではなく、NFSのデータとMySQLのダンプデータを載せ替えることと、GKE特有の設定の修正だけだった。

具体的には

  * nodeSelectorの削除
  * gcePersistentDiskをhostPathに変更
  * ingressの静的IPアドレス設定を削除
  * ingressタイプをgceからnginxに変更 (annotationのingress.classをgceからnginxに変更)
  * ingressのpathsで、既存の/\*だけではなく/も追加 (GCEでは/\*だけでも動いた）
  * readinessProbeとlivenessProbeの秒数を長めに (スペックが落ちるので)

これでクレジット切れでサーバ運用費が極端に高くなることはなくなった。
  
この調子で他のメールサーバやjenkinsもkubenetesに集約して節約したい。

今回は調べた限りで一番安かったVultrというVPSサービスを利用した。
  
メモリ512MBで2.5ドル、1GBでは5ドルで、さくらVPSと比べるとほぼ半額ほど。
  
海外のサービスだけど東京リージョンもあるので、何ら不自由なく使えている。

ちなみに登録は下記バナーからしていただけると私にデポジットが入るので是非。
  
[<img src="https://www.vultr.com/media/banner_3.png" width="300" height="250" />](https://www.vultr.com/?ref=7168447)