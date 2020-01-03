---
author: kter
categories:
- Docker
date: "2019-04-07T12:00:00Z"
id: 615
image: null
tags:
- Docker
- PHP
- LaraDock
title: Laravel入門 -Laradock導入-
---
# はじめに

## Laradockについて

PHPを開発するのに必要なアプリが全部セットになったDocker環境。
今回はMySQL + PHP-FPM + NGINX + Laravelでいきますが、データベースにPostgreSQLを選んだり、WebサーバにApacheを選んだりかなり自由度は高いです。

## ディレクトリ構成

```
.
├── laradock-dakoku ←Laradockのコード (docker-composeコマンドはここで実行)
└── src ←Laravelのコード (コンテナに入らずエディタで編集できる)
```

# コンテナを動かすための初期設定

```bash
PROJECT=(プロジェクト名)
mkdir $PROJECT
cd !$
# イメージを他プロジェクトと共用しないよう名前を変える
git clone https://github.com/Laradock/laradock.git laradock-$PROJECT
cd laradock-$PROJECT
cp env-example .env
```

```:.env
DB_HOST=mysql
APP_CODE_PATH_HOST=../src
# MySQL8の認証方式caching_sha2_passwordにPHPのMySQLライブラリが対応していないため
MYSQL_VERSION=5.7.25
```

# コンテナを動かす

```bash
docker-compose up -d nginx mysql workspace
```

# Laravelをインストール

```bash
docker-compose exec workspace bash
# バージョンは好きなものを指定する。ここでは5.2系
composer create-project laravel/laravel . "5.2.*"
```

# DB migrate実行

```:.env
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=default
DB_USERNAME=default
DB_PASSWORD=secret
```

```bash
php artisan migrate
```

# NGINX設定

```bash
cp nginx/sites/laravel.conf.example nginx/sites/laravel.conf
```

```:nginx/sites/laravel.conf
root /var/www/src/public;
```

```bash
docker-compose stop nginx
docker-compose up -d nginx
```

# Webブラウザでアクセス

https://localhost/

# Q&A

Q1. artisanコマンドはどうやって実行すればいい？
A1. laradockのディレクトリで`docker-compose exec workspace bash`

Q2. NGINXのログはどこ？
A2. laradock配下の`logs/nginx`

Q3. MySQLのデータはどこ？
A3. laradockの.envファイル、DATA_PATH_HOSTに定義されている場所 (デフォルトは~/.laradock/data)。


