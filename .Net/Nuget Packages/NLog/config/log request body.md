# log request body

參考：
- [AspNet Request posted body layout renderer](https://github.com/NLog/NLog/wiki/AspNet-Request-posted-body-layout-renderer)

要注意
```
會造成 Log 內容過大
因為當讀取到 Request Body 後，之後的 Log 內容都會帶上 Request Body
所以要注意設定檔案大小，或是設定檔案數量。
```

## 使用方法

nlog.config 中 layout 加上 ${aspnet-request-posted-body}

例：

```xml
<!-- File Target for all log messages with basic details -->
<target xsi:type="File" 
        name="allfile" 
        fileName="Log/nlog-AspNetCore-all-${shortdate}.log"
        layout="${longdate} | ${event-properties:item=EventId:whenEmpty=0} | ${level:uppercase=true} | ${aspnet-request-connection-id} | ${logger} | ${message} ${exception:format=tostring} | requestBody: ${aspnet-request-posted-body} " />
```

program.cs 加上下面程式碼

```cs
app.UseMiddleware<NLog.Web.NLogRequestPostedBodyMiddleware>(new NLog.Web.NLogRequestPostedBodyMiddlewareOptions
{
    // MaxContentLength  = 0,
    // AllowContentTypes = null,
    // ShouldCapture     = null
});
```
