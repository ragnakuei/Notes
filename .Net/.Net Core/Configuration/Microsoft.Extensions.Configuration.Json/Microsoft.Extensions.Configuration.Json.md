# Microsoft.Extensions.Configuration.Json

不同 json 結構內的相同的 path 可以重複，但 property 最好不要重複

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

## [AddJsonFile](https://docs.microsoft.com/zh-tw/dotnet/api/microsoft.extensions.configuration.jsonconfigurationextensions.addjsonfile)

總共用四個 overload
