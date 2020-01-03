---
author: kter
categories:
- jQuery
date: "2019-04-23T12:00:00Z"
id: 618
image: null
tags:
- jQuery
title: jQueryのajaxデバッグ方法
---
表題の通り、jQueryのajaxをデバッグするには、コールバックを登録すればいいらしい。
ついでにキャッシュも無効化しよう。

```js:before.js
$.ajax({
    type: 'GET',
    url: '/api.php',
    dataType: 'json',
    data: {
        hoge: 'hage'
    },
    async: false
})
.done(function(response) {
    result = response;
})
.fail(function () {
    console.log('error');
});
```

```js:after.js
$.ajax({
    type: 'GET',
    url: '/api.php',
    dataType: 'json',
    data: {
        hoge: 'hage'
    },
    async: false,
    cache: false,
    success: function(result){
      console.debug("result" + result);
    },
    error: function(jqxhr, status, exception) {
      console.debug('jqxhr', jqxhr);
      console.debug('status', status);
      console.debug('exception', exception);
    }
})
.done(function(response) {
    result = response;
})
.fail(function () {
    console.log('error');
});
```

