---
author: kter
categories:
- Elasticsearch
date: "2018-09-26T12:00:00Z"
id: 601
image: null
tags:
- Elasticsearch
- Kibana
title: 'Kibana+ElasticSearchで検索した時Courier Fetch: X of Y shards failedとエラーが出てしまったときの対処'
---
Kibana+ElasticSearchで検索した時、Courier Fetch: X of Y shards failedとエラーが出てしまったときの対処

結論から言うとおかしなインデックスを削除したら直りました。

#### 1. インデックスを確認

```
curl localhost:9200/_cat/shards?v  | awk '{ print $1 }' | sort | uniq
index
.kibana
logstash-2018.09.12
logstash-2018.09.13
logstash-2018.09.14
logstash-2018.09.15
logstash-2018.09.16
logstash-2018.09.17
logstash-2018.09.18
logstash-2018.09.19
logstash-2018.09.20
logstash-2018.09.21
logstash-2018.09.22
logstash-2018.09.23
logstash-2018.09.24
logstash-2018.09.25
logstash-2018.09.26
logstash-503830.12.31 # こんな感じの変なインデックスがある
```

#### 2. インデックスの削除

```
curl -XDELETE localhost:9200/logstash-503830.12.31?pretty
```

#### 3. 再起動

```
service elasticsearch restart
```


こうなった原因ははっきりとはしませんが、直近で大量のドキュメントがElasticSearchに流れ込み、負荷が高い状態が続いた時があったので、そのときにインデックスが変になってしまったのかもしれません。

