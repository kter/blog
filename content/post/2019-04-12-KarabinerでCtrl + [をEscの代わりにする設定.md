---
author: kter
categories:
- Mac
date: "2019-04-12T12:00:00Z"
id: 616
image: null
tags:
- Mac
- Karabiner
title: KarabinerでCtrl + [をEscの代わりにする設定
---
表題の通りKarabinerでCtrl + [をEscの代わりにする設定です。

VSCodeでVimのキーバインドを導入した際、EscがCtrl+]に割り当てられており、キーバインドを変更してみたのですが、効果がなかったのでOSレベルでキーバインドを変更してしまいます。

```json:~/.config/karabiner/assets/complex_modifications/vim-esc.json
{
    "title": "Change ctrl+[ to ESC",
    "rules": [{
        "description": "Change ctrl+[ key to Escape key",
        "manipulators": [{
            "type": "basic",
            "from": {
                "key_code": "open_bracket",
                "modifiers": {
                    "mandatory": ["control"]
                }
            },
            "to": [{
                "key_code": "escape"
            }]
        }]
    }]
}
```

上記ファイルを作成すれば自動的にComplex ModificationsのAdd Rule内に項目が出てくるのでEnableをクリックするだけです。

ちなみに環境はMac (JIS配列) + 外付けUS配列キーボードでした。

