# 讀取 wwwroot 的方式

## 啟用可讀取 wwwroot 的功能

Startup.Configure()

```csharp
app.UseStaticFiles();
```

## 讓非 api 開頭又找不到的 route 導到 wwwroot/index.html 中

可以用來整合 vue

[參考資料](https://blog.poychang.net/vue-cli-with-dotnet-core-api/)

```csharp
app.Use(async (context, next) =>
        {
            await next();

            // 判斷是否是要存取網頁，而不是發送 API 需求
            if (context.Response.StatusCode                             == 404   // 該資源不存在
                && System.IO.Path.HasExtension(context.Request.Path.Value) == false // 網址最後沒有帶副檔名
                && context.Request.Path.Value.StartsWith("/api")           == false // 網址不是 /api 開頭
                )
            {
                context.Request.Path        = "/index.html"; // 將網址改成 /index.html
                context.Response.StatusCode = 200;           // 並將 HTTP 狀態碼修改為 200 成功
                await next();
            }
        });
```
