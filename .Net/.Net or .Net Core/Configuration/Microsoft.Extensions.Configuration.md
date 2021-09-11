# Microsoft.Extensions.Configuration

預設以這個套件來處理 Configuration

可直接在 Startup.cs 中呼叫 ConfigurationExtensions 來讀取設定

```csharp
var dbType = ConfigurationExtensions.GetConnectionString(Configuration, "WfDBConnectionType");
var sqlConnectionString = ConfigurationExtensions.GetConnectionString(Configuration, "WfDBConnectionString");
```

