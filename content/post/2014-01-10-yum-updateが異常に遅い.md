---
author: kter
categories:
- 未分類
date: "2014-01-10T00:00:00Z"
id: 107
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- 28839ad5df594bb512c5fae1bc0098cc
rss_pi_source_url:
- http://blog.kter.jp/blog/yum-update-too-slow/
title: yum updateが異常に遅い
---
yum updateが異常に遅い(10kbpsほどの)マシンがあり、その解決に手間取ったので解決策をここに書き記しておきます。

まず、yumでfastestmirrorプラグインが有効になっているかどうか確認します。

確認方法は、yum updateの実行の際、Loaded plugins: fastestmirrorと表示されれば有効になっています。

有効になっている場合はキャッシュファイルを削除してみます。キャッシュファイルは、/etc/yum/pluginconf.d/fastestmirror.confのhostfilepathという項目に場所が書いてあります。

私の場合は/var/cache/yum/timedhosts.txtでした。これをリネームして読み込まないようにしてみます。

これでも解決しませんでしたので、/sbin/ifconfigでインターフェースの状態を確認してみます。

すると、errorパケットがかなりあり、現在進行形で増えているようでした。

/sbin/ethtool eth0でさらに詳しく状態を見てみると、Speedが100Mb/sに設定されていました。

他のマシンは1000Mbpsで設定されていたので設定を合わせます。

/etc/sysconfig/network-scripts/ifcfg-eth0を確認してみると、ETHTOOL_OPTS="autoneg off speed 100 duplex full"とあったので、Speedを1000に設定して/etc/init.d/network restartで再起動して有効にしようとしました。

しかし、Bringing up interface eth0: Cannot set new settings: Invalid argumentというエラーが表示されて変更できないようでした。

/sbin/ethtool -s eth0 speed 1000 duplex full autoneg offを実行しても下記のような同様の結果でした。

Cannot set new settings: Invalid argument
  
not setting speed
  
not setting duplex
  
not setting autoneg

おかしいなーと思いつつググると、Speedが1000の時はautonegがonになっている必要があるとの情報を発見しました。

<http://www.atmarkit.co.jp/bbs/phpBB/viewtopic.php?topic=40505&forum=10&start=16>

さっそく/sbin/ethtool -s eth0 speed 1000 duplex full autoneg onを実行したところうまく設定することができました。

再起動しても有効になるよう、ifcfg-eth0にもETHTOOL_OPTS="autoneg on speed 1000 duplex full"と書いておきます。

最後にyum updateを実行すると一瞬でダウンロードが終わりましたｗ

Source: New feed