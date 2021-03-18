# 在  WebApiConfig.cs Register() 中的註冊服務

- 全域性 - 每個 request 都會判斷
- 順序性 - 依註冊順序執行，建議先思考好流程

```csharp
// Web API 設定和服務
config.EnableSystemDiagnosticsTracing();

config.Filters.Add(new ElmahErrorAttribute());
config.Filters.Add(new ApiVersionAttribute());
config.Filters.Add(new ApiRunTimeAttribute());

config.MessageHandlers.Add(new DebugWriteHandler());
config.MessageHandlers.Add(new DirectlyResponseHandler());
config.MessageHandlers.Add(new ApiKeyHandler("Test"));

// Web API 路由
config.MapHttpAttributeRoutes();
```

參考資料

- [Text] (https://dotblogs.azurewebsites.net/alenwu_coding_blog/2017/11/29/140308?utm_content=buffer96f97&utm_medium=social&utm_source=facebook.com&utm_campaign=buffer)
