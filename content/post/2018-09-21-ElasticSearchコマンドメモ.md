---
author: kter
categories:
- Elasticsearch
date: "2018-09-21T12:00:00Z"
id: 600
image: null
tags:
- Elasticsearch
title: ElasticSearchコマンドメモ
---
絶対忘れるので使ったコマンドを書いておく。

ElasticSearch 5.5で確認

インデックスを確認

```
curl -XGET localhost:9200/_cat/indices
```

指定したフィールドを取得

```
curl -XGET 'http://localhost:9200/(インデックス名)/_search?pretty' -d '
{
  "_source": [ "(取得するフィールド名1)", "(取得するフィールド名2)"]
}'
```

指定フィールドから指定文字列を検索

```
curl -XGET 'http://localhost:9200/(インデックス名)/_search?pretty' -d '
{
  "_source": [ "(取得するフィールド名1)", "(取得するフィールド名2)"],
  "query":{
    "match":{
      "(検索フィールド名)": {
        "query": "(検索文字列)",
        "type": "phrase"
      }
    }
  }
}'
```

指定フィールドから指定文字列を検索 (AND検索)

```
curl -XGET 'http://localhost:9200/(インデックス名)/_search?pretty' -d '
{
  "_source": [ "(取得するフィールド名1)", "(取得するフィールド名2)"],
  "query":{
    "bool":{
      "must": [
      {
        "match":{
          "(検索フィールド名)": {
            "query": "(検索文字列)",
            "type": "phrase"
          }
        }
      },
      {
        "match":{
          "(検索フィールド名)": {
            "query": "(検索文字列)",
            "type": "phrase"
          }
        }
      }
      ]
    }
  }
}'
```

指定フィールドから指定文字列を検索 (OR検索)

```
curl -XGET 'http://localhost:9200/(インデックス名)/_search?pretty' -d '
{
  "_source": [ "(取得するフィールド名1)", "(取得するフィールド名2)"],
  "query":{
    "bool":{
      "should": [
      {
        "match":{
          "(検索フィールド名)": {
            "query": "(検索文字列)",
            "type": "phrase"
          }
        }
      },
      {
        "match":{
          "(検索フィールド名)": {
            "query": "(検索文字列)",
            "type": "phrase"
          }
        }
      }
      ]
    }
  }
}'
```

