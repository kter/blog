---
author: kter
categories:
- Ruby
date: "2018-12-29T12:00:00Z"
id: 610
image: null
tags:
- Ruby
- Rails
- Google
- devise
- OmniAUth
title: gem omniauth-google-oauth2を使ってGoogle認証を使う (Rails5版)
---
先日[こちら](https://qiita.com/bino98/items/596b5cffeca7c104bd90)の記事を参考に、omniauth-google-oauth2を使ってGoogle認証を試しました。

大体はそのままで動いたものの、記事が書かれてから２年以上立っており、動かない部分もあったため、備忘録として構築手順を残したいと思います。

リポジトリはこちら。
https://github.com/kter/qiita-omniauth-google-oauth2-test

# Google側の設定

Google側の設定は参考にさせていただいた[記事](https://qiita.com/bino98/items/596b5cffeca7c104bd90)通りにやればほぼほぼ大丈夫です。

# 準備

## ファイルの設置

RailsとDB(MySQL)はdocker-composeで動かすので、その設定を行います。


Dockerfile

```Dockerfile:Dockerfile
FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
```

docker-compose.yml

```yaml:docker-compose.yml
version: '3'
services:
  db:
    image: mysql:5.7.23
    env_file: .env
    volumes:
      - ./mysql-data:/var/lib/mysql
  web:
    build: .
    command: bundle exec rails s -p 80 -b '0.0.0.0'
    volumes:
      - .:/myapp
    ports:
      - "80:80"
    depends_on:
      - db
    env_file: .sec_env

volumes:
  db-data:
    driver: local
```

.env

```bash:.env
# for local development purpose
MYSQL_ROOT_PASSWORD=omni
MYSQL_USER=omni
MYSQL_PASSWORD=omni
```

.sec_env

```bash:.sec_env
GOOGLE_APP_ID=(クライアントID)
GOOGLE_APP_SECRET=(クライアントシークレット)
```

Gemfile

```ruby:Gemfile
source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
```

Gemfile.lock

```:Gemfile.lock
(空ファイル)
```

## イメージのビルド

コンテナイメージをビルドします

```bash
docker-compose build
```

Railsアプリを作成する

```bash
docker-compose run web rails new . --force --database=mysql
```

## 設定

データベースの設定

```:config/database.yml
  password: omni
  host: db
```

GemfileにDevise gemを追加

```ruby:Gemfile
gem 'devise'
gem 'omniauth'
gem 'omniauth-google-oauth2'
```

Deviseをインストール

```bash
docker-compose build
docker-compose run web bundle exec bin/rails g devise:install
docker-compose run web bundle exec bin/rails g devise user
```

マイグレーションファイルのcreate_table内に記述

```
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string :users, :provider
      t.string :users, :uid
      t.string :users, :token
      t.string :users, :name

```

マイグレーション反映

```bash
docker-compose run web bundle exec bin/rake db:create
docker-compose run web bundle exec bin/rake db:migrate
```

Userモデル設定

```ruby:app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :trackable, :omniauthable, omniauth_providers: %i(google)

  protected
  def self.find_for_google(auth)
    user = User.find_by(email: auth.info.email)

    unless user
      user = User.create(name:     auth.info.name,
                         provider: auth.provider,
                         uid:      auth.uid,
                         token:    auth.credentials.token,
                         email:    auth.info.email)
                         # password: Devise.friendly_token[0, 20],
                         # meta:     auth.to_yaml)
    end
    user
  end

end
```

config/initializers/devise.rbに追記

```ruby:config/initializers/devise.rb
  config.omniauth :google_oauth2,
    ENV['GOOGLE_APP_ID'],
    ENV['GOOGLE_APP_SECRET'],
    name: :google,
    scope: %w(email)
```

ログインリンク設置用ページ作成

```bash
docker-compose run web bundle exec bin/rails g controller home index
```

ログインリンクをapp/views/home/index.html.erbに設定

```ruby:app/views/home/index.html.erb
<%= link_to 'Signin with Google', user_google_omniauth_authorize_path %>

<%= current_user.inspect %>
```

config/routes.rbの```devise_for :users```を下記行に置き換える

```ruby:config/routes.rb
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
```

app/controllers/users/omniauth_callbacks_controller.rbに下記内容のファイルを作成

```ruby:app/controllers/users/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google
    @user = User.find_for_google(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def after_sign_in_path_for(resource)
    home_index_path
  end
end
```

ログインリンクを押下すれば認証できます！

```bash
docker-compose up
```

http://localhost/home/index

<img width="1313" alt="スクリーンショット 2018-12-29 21.09.28.png" src="https://qiita-image-store.s3.amazonaws.com/0/27674/efcaa91a-fff6-de4c-69a3-5f4d3a9ef1e0.png">

