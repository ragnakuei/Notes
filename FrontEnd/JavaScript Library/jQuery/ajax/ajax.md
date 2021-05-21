# ajax


## request 使用 content type multipart/form-data

```js
let formData = new FormData();
formData.append('json', JSON.stringify( requestBody ))

$.ajax({
            url: '/api/CheckItem.aspx',
            async: false,
            type: 'post',
            data: formData,
            processData: false,
            contentType: false,
        })
    .done(function(res) {
            console.log('done', res);
        })
    .fail(function(res) {
            console.log('error', res);
        });
```

## request 使用 content type json

```js
$.ajax({
    url: searchEmployeeApiUrl,
    type: 'post',
    data: JSON.stringify({ keyword: request.term }),
    dataType: 'json',
    contentType: 'application/json',
    // processData: false,   // 不讓 jQuery 做額外的處理，適合用於只傳簡單型別的資料
    success: response,
    error: function () {
        response([]);
    }
})
```

```js
$.ajax({
            url: sumbitUrl,
            type: 'post',
            data: JSON.stringify( model ),
            dataType: 'json',
            contentType: 'application/json',
        })
 .done(function(res) {
            console.log('done', res);
            window.location.href = redirectUrl;
        })
 .fail(function(res) {
            console.log('error', res);
        });
```


- 設定 dataType 為 json
- 設定 contentType 為 `application/json`
- data - 必須使用 JSON.stringfy(js object)
- 在 chrome dev tools 中會看到 Request Body 的項目為 `Request Payload` 而不是 `Form Data`
- [測試結果](./../../../.Net/.Net%20Core/ASP.NET%20Core/Model%20Binding/FromForm.md)

[相關範例](./將%20$(form)%20轉成%20object.md#複雜型別)

## [life cycle](https://api.jquery.com/Ajax_Events/)
[ajaxSend()](https://api.jquery.com/ajaxsend/)


## request body 傳簡單型別

```javascript
$.ajax({
    url: searchEmployeeApiUrl,
    type: 'post',
    data: { keyword: request.term },
    dataType: 'json',
    contentType: 'application/json',

    // 不讓 jQuery 做額外的處理，適合用於只傳簡單型別的資料
    processData: false,

    success: response,
    error: function () {
        response([]);
    }
})