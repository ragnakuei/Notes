# 搭配 Log 機制

WebApiConfig.cs

```csharp
config.MessageHandlers.Add(new LoggerHandler());
```

```csharp
public class LoggerHandler : DelegatingHandler
{
    protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
    {
        Logger(request);
        return base.SendAsync(request, cancellationToken);
    }

    /// <summary>
    /// 日誌記錄
    /// </summary>
    /// <param name="request">請求</param>
    private void Logger(HttpRequestMessage request)
    {
        var info = new LogInfo
        {
            HttpMethod = request.Method.Method,
            UriAccessed = request.RequestUri.AbsoluteUri,
            IPAddress = HttpContext.Current != null ? HttpContext.Current.Request.UserHostAddress : "0.0.0.0",
        };

        // 讀取 Body
        request.Content?.ReadAsByteArrayAsync()
            .ContinueWith((task) =>
            {
                info.BodyContent = Encoding.UTF8.GetString(task.Result);
            });

        // 序列化與儲存
        string json = Newtonsoft.Json.JsonConvert.SerializeObject(info);

        //輸出 log 內容
        //string uniqueid = DateTime.Now.Ticks.ToString();
        //string logfile = $"C:\\Temp\\{uniqueid}.txt";
        //System.IO.File.WriteAllText(logfile, json);

        Debug.WriteLine(json);
    }

    /// <summary>
    /// 日誌物件
    /// </summary>
    public class LogInfo
    {
        //public List<string> Header { get; set; }
        public string HttpMethod { get; set; }
        public string UriAccessed { get; set; }
        public string IPAddress { get; set; }
        public string BodyContent { get; set; }
    }
}
```

輸出格式如下

```json
{
    "HttpMethod": "GET",
    "UriAccessed": "http://localhost:49274/api/products",
    "IPAddress": "::1",
    "BodyContent": null
}
```
