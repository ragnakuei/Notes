# ajax 上傳檔案範例

```html
<p>
    <input type="file" id="NewFile" placeholder="選擇檔案" />
    <input type="button" value="上傳" id="UploadFile" />
</p>
```

```js
obj = {};
obj.Url = ''
obj.RequestBody = {}
// obj.SuccessCallback
// obj.ErrorCallback

$('#UploadFile').click(function() {
    try {
        var file = $('#NewFile').prop('files')[0];
        obj.RequestBody.append('file', file);

        $.ajax({
            beforeSend: function (request) {
                // request.setRequestHeader("", );
            },
            url: obj.Url,
            data: obj.RequestBody,
            type: 'post',

            // 以下二個為解決 Illegal invocation 的問題
            processData: false,
            contentType: false,

            success: obj.SuccessCallback,
            error: obj.ErrorCallback,
        });
    } catch (e) {
        alert('發生錯誤，請聯絡開發人員 !');
        console.log(e);
    }
}
```
