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
builder.Services.Configure<TestOption>(o => { o.Id = 3; });
```
