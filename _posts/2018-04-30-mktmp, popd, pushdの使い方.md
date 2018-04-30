---
id: 582
title: mktmp, pushd, popdの使い方
date: 2018-04-30T16:36:00+09:00
author: kter
layout: post
image: 
categories:
  - Linux
tags:
  - Linux
  - ShellScript
---

mktmp, pushd, popdはセットで使われることが多いと思います。
シェルスクリプト内で、一時ディレクトリを作成してそこにカレントディレクトリを変更し、また以前のカレントディレクトリに戻るといったときに使われます。

```bash

# (処理)

# /tmp以下に一時ディレクトリを作成し、TMPDIR変数にパスを格納
TMPDIR=$(mktemp -d --tmpdir=/tmp)
# 一時ディレクトリに移動
pushd $TMPDIR > /dev/null

# (処理)

# 元いたディレクトリに戻る
popd > /dev/null

# (処理)

```
