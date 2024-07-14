# layout renders

## ${aspnet-request-posted-body}

參考資料

- [AspNet Request posted body layout renderer](https://github.com/NLog/NLog/wiki/AspNet-Request-posted-body-layout-renderer)
- [HTTP Request Logging](https://github.com/NLog/NLog.Web/wiki/HTTP-Request-Logging)

必須要額外引用 NLog 寫好的 middleware 才會有作用，否則會在 internal log 看到對應的錯誤訊息 !

```cs
app.UseMiddleware<NLog.Web.NLogRequestPostedBodyMiddleware>(
    new NLog.Web.NLogRequestPostedBodyMiddlewareOptions()
);
```

注意事項

```
容易造成 Log 內容過大
因為當讀取到 Request Body 後，之後的 Log 內容都會帶上 Request Body
```
