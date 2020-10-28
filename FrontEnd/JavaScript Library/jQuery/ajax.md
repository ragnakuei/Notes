# ajax


## 指定 request content type

```javascript
$.ajax({
    url: searchEmployeeApiUrl,
    type: 'post',
    data: { keyword: request.term },
    dataType: 'json',
    contentType: 'application/json',
    success: response,
    error: function () {
        response([]);
    }
})
```

就算指定了 dataType 為 json ，request content type 就還是 application/x-www-form-urlencoded，必須加上 contentType 為 `application/json` 的 property 才會真的以 json 格試送出 request


## [life cycle](https://api.jquery.com/Ajax_Events/)
[ajaxSend()](https://api.jquery.com/ajaxsend/)



