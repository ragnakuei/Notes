# 避免 redirect 302 的替代做法

因為預設來說 response https code 為 302，仍然會繼續處理，故需要找到可以判斷且處理的方式 !

## 範例

- 以下範例搭配[_CustomRequest](../../JavaScript%20Library/jQuery/CustomRequest.md)
- 因為當 session 被登出後，發出 request 後，會被導至登入頁面
  - 同時會以 query string key returnUrl 來給定 request 的 url
  - 故以 responseURL 是否包含 returnUrl 來做為 302 的判斷

```js
try
{
    if (self.Waiting)
    {
        console.log('已有 request 正在等待回應中');
        return;
    }

    self.Waiting = true;

    const req = new XMLHttpRequest();
    req.open("POST", self.Option.Url, true);
    req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");

    
    req.onreadystatechange = function()
    {
        // request 完成後 並且 responseURL 包含 returnUrl 關鍵字，就不做原本的處理流程 !
        if (this.readyState === this.DONE
        && this.responseURL.indexOf('returnUrl') !== -1)
        {
            // 取消 request
            this.abort();
            self.Waiting = false;

            // 導到指定的頁面
            window.location.href = this.responseURL;
        }
    };

    req.onload = function ()
    {
        self.Waiting = false;

        if (req.status !== 200)
        {
            console.log(req);
            alert('發生錯誤，請聯絡開發人員 !');
            return;
        }

        // request 完成
    };

    req.onerror = function ()
    {
        self.Waiting = false;

        alert('發生錯誤，請聯絡開發人員 !');
    };

    if (self.FullScreenLoading)
    {
        self.FullScreenLoading.Show();
    }

    const requestBody = ToFormData(self.Option.RequestBody);
    req.send(requestBody);
}
catch (e)
{
    self.Waiting = false;

    alert('發生錯誤，請聯絡開發人員 !');
    console.log(e);
}
finally
{
    if (self.FullScreenLoading)
    {
        self.FullScreenLoading.Close();
    }
}
```