---
id: 574
title: Mailuで簡単にWebUI付きのメールサーバを立てる
date: 2018-2-6T13:15:00+09:00
author: kter
layout: post
image: 
categories:
  - Linux
tags:
  - Linux
  - Docker
  - docker-compose
  - mail
---

# はじめに

自分用のメールサーバを建てようと思った時、セキュリティを気にしながら設定を調べて…となかなか大変ですよね。

でも[Mailu](https://github.com/Mailu/Mailu)を使うと簡単にWebUI付きのメールサーバが構築できます！

![]({{site.baseurl}}/assets/img/20180206/2018-02-06-01.png)

この画像のようにWebUIからもメールの送受信ができるので便利です。

[デモサイト](https://mailu.io/demo.html)があるので興味のある方は覗いてみてください。

Mailuが備えている機能は次の通りです。

* IMAP, IMAP+, SMTPのメールサーバ
* WebUIと管理画面
* 自動返信、自動転送
* クォーターなどの管理機能
* TLS (Let's Encrypt対応！), DKIM, アンチウイルスなどのセキュリティ

詳細は[プロジェクトのページ](https://mailu.io)を見ていただくとして、早速構築してみます。

# 構築

構築はDigitalOceanという海外のVPS上のdocker-composeでやってみます。

![]({{site.baseurl}}/assets/img/20180206/2018-02-06-02.png)

ちなみに下記のリンクから登録すると10ドルのクーポンが貰えます。

一番安いインスタンスであれば2ヶ月間無料で動かせます。是非。

https://m.do.co/c/dc73cf13e37a

## 構築手順

今回は公式推奨のDebian Stretch(9.3)を使います。

インスタンスが立ち上がったらおもむろに下記コマンドを実行してください。

### 準備

{% highlight bash %}
apt update
# すべてYESと答える
apt install -y iptables-persistent
apt-get autoremove --purge exim4 exim4-base
{% endhighlight %}

### Dockerのインストール

{% highlight bash %}
# E: Unable to locate package docker-engineと言われても大丈夫
apt-get remove docker docker-engine docker.io
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce
curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
{% endhighlight %}

### Mailu設定

{% highlight bash %}
mkdir /mailu
cd /mailu
{% endhighlight %}

{% highlight yaml %}
cat << '_EOF' > docker-compose.yml
version: '2'

services:

  front:
    image: mailu/nginx:$VERSION
    restart: always
    env_file: .env
    ports:
    - "$BIND_ADDRESS4:80:80"
    - "$BIND_ADDRESS4:443:443"
    - "$BIND_ADDRESS4:110:110"
    - "$BIND_ADDRESS4:143:143"
    - "$BIND_ADDRESS4:993:993"
    - "$BIND_ADDRESS4:995:995"
    - "$BIND_ADDRESS4:25:25"
    - "$BIND_ADDRESS4:465:465"
    - "$BIND_ADDRESS4:587:587"
    volumes:
      - "$ROOT/certs:/certs"

  redis:
    image: redis:alpine
    restart: always
    volumes:
      - "$ROOT/redis:/data"

  imap:
    image: mailu/dovecot:$VERSION
    restart: always
    env_file: .env
    volumes:
      - "$ROOT/data:/data"
      - "$ROOT/mail:/mail"
      - "$ROOT/overrides:/overrides"
    depends_on:
      - front

  smtp:
    image: mailu/postfix:$VERSION
    restart: always
    env_file: .env
    volumes:
      - "$ROOT/data:/data"
      - "$ROOT/overrides:/overrides"
    depends_on:
      - front

  antispam:
    image: mailu/rspamd:$VERSION
    restart: always
    env_file: .env
    volumes:
      - "$ROOT/filter:/var/lib/rspamd"
      - "$ROOT/dkim:/dkim"
      - "$ROOT/overrides/rspamd:/etc/rspamd/override.d"
    depends_on:
      - front

  antivirus:
    image: mailu/$ANTIVIRUS:$VERSION
    restart: always
    env_file: .env
    volumes:
      - "$ROOT/filter:/data"

  webdav:
    image: mailu/$WEBDAV:$VERSION
    restart: always
    env_file: .env
    volumes:
      - "$ROOT/dav:/data"

  admin:
    image: mailu/admin:$VERSION
    restart: always
    env_file: .env
    volumes:
      - "$ROOT/data:/data"
      - "$ROOT/dkim:/dkim"
      - /var/run/docker.sock:/var/run/docker.sock:ro
    depends_on:
      - redis

  webmail:
    image: "mailu/$WEBMAIL:$VERSION"
    restart: always
    env_file: .env
    volumes:
      - "$ROOT/webmail:/data"

  fetchmail:
    image: mailu/fetchmail:$VERSION
    restart: always
    env_file: .env
    volumes:
      - "$ROOT/data:/data"
_EOF

cat << '_EOF' > .env
# Mailu main configuration file
#
# Most configuration variables can be modified through the Web interface,
# these few settings must however be configured before starting the mail
# server and require a restart upon change.

###################################
# Common configuration variables
###################################

# Set this to the path where Mailu data and configuration is stored
ROOT=/mailu

# Mailu version to run (1.0, 1.1, etc. or master)
VERSION=1.5.1

# Set to a randomly generated 16 bytes string
SECRET_KEY=

# Address where listening ports should bind
BIND_ADDRESS4=0.0.0.0
BIND_ADDRESS6=::1

# Main mail domain
DOMAIN=

# Hostnames for this server, separated with comas
HOSTNAMES=

# Postmaster local part (will append the main mail domain)
POSTMASTER=admin

# Choose how secure connections will behave (value: letsencrypt, cert, notls, mail)
TLS_FLAVOR=letsencrypt

# Authentication rate limit (per source IP address)
AUTH_RATELIMIT=10/minute;1000/hour

# Opt-out of statistics, replace with "True" to opt out
DISABLE_STATISTICS=False

###################################
# Optional features
###################################

# Expose the admin interface (value: true, false)
ADMIN=true

# Choose which webmail to run if any (values: roundcube, rainloop, none)
WEBMAIL=rainloop

# Dav server implementation (value: radicale, none)
WEBDAV=radicale

# Antivirus solution (value: clamav, none)
ANTIVIRUS=none

###################################
# Mail settings
###################################

# Message size limit in bytes
# Default: accept messages up to 50MB
MESSAGE_SIZE_LIMIT=50000000

# Networks granted relay permissions, make sure that you include your Docker
# internal network (default to 172.17.0.0/16)
RELAYNETS=172.16.0.0/12

# Will relay all outgoing mails if configured
RELAYHOST=

# Fetchmail delay
FETCHMAIL_DELAY=600

# Recipient delimiter, character used to delimiter localpart from custom address part
# e.g. localpart+custom@domain;tld
RECIPIENT_DELIMITER=+

# DMARC rua and ruf email
DMARC_RUA=admin
DMARC_RUF=admin

# Weclome email, enable and set a topic and body if you wish to send welcome
# emails to all users.
WELCOME=false
WELCOME_SUBJECT=Welcome to your new email account
WELCOME_BODY=Welcome to your new email account, if you can read this, then it is configured properly!

###################################
# Web settings
###################################

# Path to the admin interface if enabled
WEB_ADMIN=/admin

# Path to the webmail if enabled
WEB_WEBMAIL=/webmail

# Website name
SITENAME=Mailu

# Linked Website URL
WEBSITE=

###################################
# Advanced settings
###################################

# Docker-compose project name, this will prepended to containers names.
COMPOSE_PROJECT_NAME=mailu

# Default password scheme used for newly created accounts and changed passwords
# (value: SHA512-CRYPT, SHA256-CRYPT, MD5-CRYPT, CRYPT)
PASSWORD_SCHEME=SHA512-CRYPT
_EOF
{% endhighlight %}

## 設定

設定ファイルの記載とドメインの設定を行います。

### 設定ファイル編集

.envファイルをエディタで開き、下記設定を変更します。

他の設定項目については[ドキュメント](https://mailu.io/configuration.html)を参照してください。

| 設定 | 設定値 |
| --- | --- |
| SECRET_KEY | 16文字の英数文字 |
| DOMAIN | メールで使うドメイン |
| HOSTNAMES | mail.(メールで使うドメイン) |

### DNSレコードの編集

次のように編集してください。

| レコード名 | レコードタイプ | 設定値 |
| --- | --- | --- |
| (ドメイン) | A | (サーバーIPアドレス) |
| (ドメイン) | MX | 10 mail.(メールで使うドメイン) |
| mail.(ドメイン) | A | (サーバーIPアドレス) |
| (ドメイン) | SPF | "v=spf1 ip4:(サーバーIPアドレス) ~all" |
| (ドメイン) | TXT | "v=spf1 ip4:(サーバーIPアドレス) ~all" |

# 使ってみる

下記コマンドを実行してしばらく待ってください (自分は25分掛かりました)。

```docker-compose logs -f``` で進捗を確認してもいいと思います。
DHパラメータの生成やLet's Encryptによる証明書自動取得が終わると、https://mail.(メールで使うドメイン)/ でアクセスできるようになります。

{% highlight yaml %}
docker-compose up -d
{% endhighlight %}

## アカウントの設定

アカウントの設定を行います。

下記コマンドを実行してください。

{% highlight yaml %}
docker-compose run --rm admin python manage.py admin (ユーザ名) (ドメイン) (パスワード)
{% endhighlight %}

ブラウザでhttp://mail.(ドメイン)/ にアクセスし、"(ユーザ名)@(ドメイン名)"と設定したパスワードでログインします。

以上。



