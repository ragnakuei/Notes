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

有時就算指定了 dataType 為 json ，request content type 就還是 application/x-www-form-urlencoded
- 必須加上 contentType 為 `application/json` 的 property 才會真的以 json 格試送出 request
- jQuery Ajax，目前測試都是以 FormData 格式送出，而 Content-Type 只是手動指定後的結果。
  - 不管是否有使用 JSON.stringfy() 
  - 不管是否指定 Content-Type 為 json
  - [測試結果](./../../../.Net/.Net%20Core/ASP.NET%20Core/Model%20Binding/FromForm.md)

[相關範例](./將%20$(form)%20轉成%20object.md#複雜型別)

## [life cycle](https://api.jquery.com/Ajax_Events/)
[ajaxSend()](https://api.jquery.com/ajaxsend/)



