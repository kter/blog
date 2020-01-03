---
author: kter
categories:
- 未分類
date: "2014-07-08T00:00:00Z"
id: 88
rss_pi_canonical_url:
- my_blog
rss_pi_source_md5:
- 1720bc10f19c5b95af585ee48557028d
rss_pi_source_url:
- http://blog.kter.jp/blog/rails-passenger%E3%81%A7stderr-usrbinenv-ruby-no-such-file-or-directory/
title: 'Rails Passengerでstderr: &#047;usr&#047;bin&#047;env: ruby No such file or
  directory'
---
passengerを組み込んだapacheのerror_logに次の行が表示される時の対処

> App 7560 stderr: &#047;usr&#047;bin&#047;env:
  
> App 7560 stderr: ruby
  
> App 7560 stderr: : No such file or directory

apacheからパスが通っていないので、&#047;etc&#047;sysconfig&#047;httpdに次の行を追記します。

> export PATH=&#047;usr&#047;local&#047;bin:$PATH

パスは適宜変更してください。

Source: New feed