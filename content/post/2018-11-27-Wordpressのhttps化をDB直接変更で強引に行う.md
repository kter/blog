---
author: kter
categories:
- Wordpress
date: "2018-11-27T12:00:00Z"
id: 608
image: null
tags:
- Wordpress
title: Wordpressのhttps化をDB直接変更で強引に行う
---
Wordpressをhttps化したものの、一部ページ内の画像がhttpのままのため、ブラウザのアドレスバーに警告が出ていました。

1ページずつ修正するのは論外だし、プラグインを使うのも後々トラブルになりそうだったので、DBを直接弄って解決しました。

```sql

UPDATE wp_options SET option_value = replace(option_value, 'http://ドメイン', 'https://ドメイン') WHERE option_name = 'home' OR option_name = 'siteurl';
UPDATE wp_posts SET post_content = replace(post_content, 'http://ドメイン', 'https://ドメイン');
UPDATE wp_postmeta SET meta_value = replace(meta_value,'http://ドメイン','https://ドメイン');
UPDATE wp_usermeta SET meta_value = replace(meta_value, 'http://ドメイン','https://ドメイン');
UPDATE wp_links SET link_url = replace(link_url, 'http://ドメイン','https://ドメイン');
UPDATE wp_comments SET comment_content = replace(comment_content , 'http://ドメイン','https://ドメイン');
UPDATE wp_posts SET post_content = replace(post_content, 'http://ドメイン', 'https://ドメイン');
UPDATE wp_links SET link_image = replace(link_image, 'http://ドメイン','https://ドメイン');
UPDATE wp_posts SET guid = replace(guid, 'http://ドメイン','https://ドメイン');
```

