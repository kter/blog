---
id: 468
title: 'ImportError: No module named paramiko'
date: 2017-08-20T15:38:54+00:00
author: kter
layout: post
#guid: https://kter.jp/?p=468
#permalink: /?p=468
categories:
  - Ansible
  - Linux
  - Python
tags:
  - Ansible
  - Linux
  - pip
  - Python
---
Ansible徹底入門を写経していたところ、Dynamic Inventoryのvagrant.py実行で下記エラーが出てしまった。

<pre class="lang:default decode:true">ImportError: No module named paramiko
</pre>

&nbsp;

元入ってるpythonとこの本に従って入れたpythonがごっちゃになっているようだった。

vagrant.pyの実行だけなら &#8220;\`python2 ./vagrant.py&#8220;\` で動くが、ansible-playbookでインベントリにvagrant.pyを使うとなるとエラーとなる。

そこで[virtualenv](https://virtualenv.pypa.io/en/stable/)を使って、ディレクトリ単位でpythonを管理する。

&nbsp;

具体的には次のようにする。

<pre class="lang:default decode:true ">sudo pip install virtualenv
virtualenv .
source bin/activate
pip install ansible
</pre>

&nbsp;

virtualenv環境を終了する場合は次のコマンドを実行する。

<pre class="lang:default decode:true ">deactivate</pre>

&nbsp;

&nbsp;