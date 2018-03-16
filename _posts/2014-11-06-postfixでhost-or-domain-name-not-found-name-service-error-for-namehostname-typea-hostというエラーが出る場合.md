---
id: 83
title: 'PostfixでHost or domain name not found. Name service error for name=hostname type=A: Hostというエラーが出る場合の対処'
date: 2014-11-06T00:00:00+00:00
author: kter
layout: post
#guid: http://blog.kter.jp/?p=83
#permalink: /?p=83
rss_pi_source_url:
  - 'http://blog.kter.jp/blog/postfix%E3%81%A7host-or-domain-name-not-found-name-service-error-for-namehostname-typea-host%E3%81%A8%E3%81%84%E3%81%86%E3%82%A8%E3%83%A9%E3%83%BC%E3%81%8C%E5%87%BA%E3%82%8B%E5%A0%B4%E5%90%88/'
rss_pi_source_md5:
  - 400e938383c3e8bf2241da81357c574a
rss_pi_canonical_url:
  - my_blog
categories:
  - 未分類
---
CentOSのPostfixで
  
Host or domain name not found. Name service error for name=hostname type=A: Host&nbsp;not found
  
などというエラーが出て上手くいかない時

設定が合っている場合でもOS側でsendmailが選択されている場合があります。

sudo alternatives &#8211;config mtaコマンドでpostfixを選択してみてください。

Source: New feed