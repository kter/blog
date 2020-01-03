---
author: kter
categories:
- 未分類
date: "2014-04-12T00:00:00Z"
id: 99
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- c36fe37d904d77e90946520de639873b
rss_pi_source_url:
- http://blog.kter.jp/blog/zabbix-server2-2%E3%82%92rpm%E3%81%A0%E3%81%91%E3%81%A7%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B/
title: Zabbix-Server2.2をRPMだけでインストールする
---
やたら依存パッケージが多いのでメモを残しておきます。ちなみにMySQL使う場合です

PHPをソースからインストールした場合は少し違うかも知れません

<pre>cd &#047;usr&#047;local&#047;src<br />
wget http:&#047;&#047;repo.zabbix.com&#047;zabbix&#047;2.2&#047;rhel&#047;6&#047;x86_64&#047;zabbix-2.2.2-1.el6.x86_64.rpm<br />
wget http:&#047;&#047;repo.zabbix.com&#047;zabbix&#047;2.2&#047;rhel&#047;6&#047;x86_64&#047;zabbix-web-2.2.2-1.el6.noarch.rpm<br />
wget http:&#047;&#047;repo.zabbix.com&#047;zabbix&#047;2.2&#047;rhel&#047;6&#047;x86_64&#047;zabbix-web-japanese-2.2.2-1.el6.noarch.rpm<br />
wget http:&#047;&#047;repo.zabbix.com&#047;zabbix&#047;2.2&#047;rhel&#047;6&#047;x86_64&#047;zabbix-server-2.2.2-1.el6.x86_64.rpm<br />
wget http:&#047;&#047;repo.zabbix.com&#047;zabbix&#047;2.2&#047;rhel&#047;6&#047;x86_64&#047;zabbix-server-mysql-2.2.2-1.el6.x86_64.rpm<br />
wget http:&#047;&#047;repo.zabbix.com&#047;zabbix&#047;2.2&#047;rhel&#047;6&#047;x86_64&#047;zabbix-web-mysql-2.2.2-1.el6.noarch.rpm<br />
sudo yum install php-bcmath<br />
sudo yum install OpenIPMI-libs unixODBC OpenIPMI OpenIPMI-libs vlgothic-p-fonts dejavu-sans-fonts glibc-devel gnutls-devel glibc-2.12-1.132.el6.i686 gnutls-2.8.5-13.el6_5.i686<br />
wget http:&#047;&#047;pkgs.repoforge.org&#047;fping&#047;fping-3.9-1.el6.rf.x86_64.rpm<br />
sudo rpm -rpm -ivh fping-3.9-1.el6.rf.x86_64.rpm<br />
wget http:&#047;&#047;pkgs.repoforge.org&#047;iksemel&#047;iksemel-devel-1.4-1.el6.rf.i686.rpm<br />
sudo rpm -ivh iksemel-devel-1.4-1.el6.rf.i686.rpm<br />
wget http:&#047;&#047;pkgs.repoforge.org&#047;iksemel&#047;iksemel-1.4-1.el6.rf.i686.rpm<br />
wget ftp:&#047;&#047;ftp.pbone.net&#047;mirror&#047;atrpms.net&#047;el6-x86_64&#047;atrpms&#047;stable&#047;libiksemel3-1.4-2_2.el6.x86_64.rpm<br />
sudo rpm -ivh libiksemel3-1.4-2_2.el6.x86_64.rpm<br />
sudo rpm -ivh zabbix-server-mysql-2.2.2-1.el6.x86_64.rpm zabbix-server-2.2.2-1.el6.x86_64.rpm<br />
sudo rpm -ivh zabbix-web-*</pre></p> 

Source: New feed