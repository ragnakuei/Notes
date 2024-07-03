# Options Pattern

-   共通點
-   在 DI Container 中
-   註冊 TestOption 類別
-   如果該類別未建立，則會自動建立
-   如果該類別已建立，則會回傳該類別的 instance (Singleton)
    -   正因為是 Singleton，所以非必要，就不要賦與修改值的權利 !

```cs
// 從 appsettings.json 中取得 TestOption 的設定值
builder.Services.AddOptions<TestOption>().Bind(builder.Configuration.GetSection("TestOption"));

// 並且設定 TestOption instance 的屬性值
// 通常搭配 Configuration 來使用
builder.Services.Configure<TestOption>(o => { o.Id = 3; });
```

##

DI Options 的三種 interface

-   [IOptions<TOptions>](https://learn.microsoft.com/en-us/dotnet/api/microsoft.extensions.options.ioptions-1)
-   [IOptionsSnapshot<TOptions>](https://learn.microsoft.com/en-us/dotnet/api/microsoft.extensions.options.ioptionssnapshot-1)
-   [IOptionsMonitor<TOptions>](https://learn.microsoft.com/en-us/dotnet/api/microsoft.extensions.options.ioptionsmonitor-1)

    支援 Reloadable configuration 前置動作
    需要在讀取 appsettings.json 的 AddJsonFile() 參數 reloadOnChange 設定為 true
    也就是在讀取檔案時也要加上 monitor 的設定 !
