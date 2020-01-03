---
author: kter
categories:
- Ansible
date: "2017-12-08T16:29:47Z"
id: 560
image: /wp-content/uploads/2017/07/logo.png
tags:
- Ansible
title: AnsibleでLetsencryptによる証明書を自動作成する
---

証明書を作成するためにはドメインを登録しないといけませんが、下記Taskで自動作成できます。

登録するIPアドレスはipify.orgで取得しています。

注意点としてはfullchain-pathで指定したディレクトリ配下にdomain1の名前でディレクトリが作成され、そのディレクトリ内に証明書と秘密鍵が生成されることです。

```yaml
- name: "外部アドレスを取得"
  uri:
    url: https://api.ipify.org/
    return_content: yes
  register: external_address

- name: "レコード登録 (反映を待つので少し時間がかかります)"
  route53:
    aws_access_key: (アクセスキー)
    aws_secret_key: (シークレットアクセスキー)
    command: create
    zone: (Route53ゾーン名)
    record: "{{ item }}"
    type: A
    ttl: 300
    value: "{{ external_address.content }}"
    wait: yes
  with_items:
    - (ドメイン1)
    - (ドメイン2)

- name: "certbot インストールディレクトリの作成"
  file: path=/opt/certbot state=directory owner=root group=root mode=0755

- name: "certbot のダウンロード"
  get_url:
    url: https://dl.eff.org/certbot-auto
    dest: /opt/certbot/certbot-auto
    mode: 755

- name: "certbot を実行してSSL証明書を取得"
  shell: |
    /opt/certbot/certbot-auto certonly \
      --debug \
      --text \
      --non-interactive \
      --agree-tos \
      --standalone \
      --fullchain-path=(設置場所) \
      --email (メールアドレス) \
      -d (ドメイン1) \
      -d (ドメイン2)
```
