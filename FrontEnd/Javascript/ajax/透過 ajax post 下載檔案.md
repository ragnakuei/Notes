# 透過 ajax post 下載檔案

## 範例

以下範例搭配[_CustomRequest](../../JavaScript%20Library/jQuery/CustomRequest.md)

- 因為使用 jQuery 發生不明錯誤，短時間內無法解決，以 XMLHttpRequest 測試成功 !

```js
self.PostDownloadFile = function()
{
    try
    {
        const req = new XMLHttpRequest();

        // 指定 Http Method 及 Url 及 是否使用 async
        req.open("POST", self.Option.Url, true);

        // 套用 asp.net core 需要的 CSRF Antiforgery Token
        req.setRequestHeader("@(ViewParameter.RequestVerificationToken)", Antiforgery.@(ViewParameter.RequestVerificationToken));
        req.responseType = "blob";

        req.onload = function (event) 
        {
            const blob = req.response;
            console.log(blob);

            // 解析 file name
            let filename = "defaultFile";
            const disposition = req.getResponseHeader('Content-Disposition');
            if (disposition && disposition.indexOf('attachment') !== -1) 
            {
                const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                const matches = filenameRegex.exec(disposition);
                if (matches != null && matches[1]) {
                    filename = matches[1].replace(/['"]/g, '');
                }
            }

            const link=document.createElement('a');
            link.href=window.URL.createObjectURL(blob);
            link.download=filename;
            link.click();
        };

        // request body 放在這
        req.send(self.Option.RequestBody);
    }
    catch (e)
    {
        alert('發生錯誤，請聯絡開發人員 !');
        console.log(e);
    }
}
```