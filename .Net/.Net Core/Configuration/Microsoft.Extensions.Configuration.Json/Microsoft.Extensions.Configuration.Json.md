# Microsoft.Extensions.Configuration.Json

## 是否需要複製 configuration files 至指定目錄

ASP.NET Core 專案
```
因為 ASP.NET Core 執行目錄是固定的
所以不需要將 appsettings.json 複製到特定的目錄
```

Console 專案
```
因為此框架的做法就像 Windows Console 執行檔一樣
具有可攜性，所以必須讓 設定檔 同步複製到編譯後的資料夾中
```



