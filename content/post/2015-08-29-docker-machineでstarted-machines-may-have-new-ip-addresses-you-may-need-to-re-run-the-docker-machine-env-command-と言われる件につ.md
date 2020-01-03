---
author: kter
categories:
- 未分類
date: "2015-08-29T00:00:00Z"
id: 58
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- e1d3c41a27c659ae6ad0d705d180eea6
rss_pi_source_url:
- http://blog.kter.jp/blog/started-machines-may-have-new-ip-addresses/
title: docker-machineでStarted machines may have new IP addresses. You may need to
  re-run the `docker-machine env` command.と言われる件について
---
docker-machineでStarted machines may have new IP addresses. You may need to re-run the \`docker-machine env\` command.と言われる件について

<blockquote class="twitter-tweet" lang="ja">
  <p dir="ltr" lang="ja">
    docker-machine startを実行するとdocker-machine envを実行しろと言われ、docker-machine envを実行するとdocker-machine startを実行しろと言われるので詰んだ
  </p>
  
  <p>
    &mdash; ことえり (@kter) <a href="https:&#047;&#047;twitter.com&#047;kter&#047;status&#047;637494883276591104">2015, 8月 29</a>
  </p>
</blockquote>



とdocker-machine envを実行してもdocker-machine startを実行しろと言われ堂々巡りに。

おもむろにVirtualBoxで直接起動しようとしたらエラーがでて起動できませんでした。

VirtualBoxのバグのようなので4.3にダウングレードしました。

その後docker-machine start default, docker-machine regenerate-certs default, docker-machine env defaultで無事dockerが使えるようになりました。</p> 

Source: New feed