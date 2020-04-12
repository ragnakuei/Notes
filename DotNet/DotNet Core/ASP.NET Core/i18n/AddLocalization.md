# AddLocalization

Package：`Microsoft.Extensions.Localization`

---

## 設定方式

預設會找 `專案目錄/Resources` 內的 resx 檔案

### ConfigureServices()

startup.cs > ConfigureServices() 中 可不設定 `services.AddLocalization()` ，就會套用預設值

### Configure()

startup.cs > Configure() 要透過下面的方式，才會讀取 request header Accept-Language，並且將指定的語系設定至 Thread.CurrentThread 中的 `CurrentCulture` 及 `CurrentUICulture`，後續才可以透過 [IStringLocalizer\<T>](./IStringLocalizer.md) 來讀取 Resource Files

```csharp
var locOptions = app.ApplicationServices.GetService<IOptions<RequestLocalizationOptions>>();
app.UseRequestLocalization(locOptions.Value);
```

---

## 自訂 Resources 路徑

透過 LocalizationOptions 來自訂 Resources 路徑

所指定的目錄一定會以 `專案目錄` 做為根目錄，並且在指定目錄下找尋 `Resources` 的子目錄

需要注意的是不支援相對路徑 `../自訂目錄` 這種方式

當 startup.cs > ConfigureServices() 中 設定以下語法時

```csharp
services.AddLocalization(options => options.ResourcesPath = "ABC")
```

就會尋找 `專案目錄/ABC/Resources` 中的 *.resx

---

## 自訂 Resources 路徑的 Debug 方式

在 Asp.Net Core 3.1 的情況下，當透過 IStringLocalizer\<T>["Key"].Value 找不到對應的 Value 時，就會直接顯示 Key 的名稱，而不會發生 Exception。

目前已知的 Debug 方式，就是透過 IStringLocalizer\<T>["Key"] 中的 `ResourceNotFound` 及 `SearchedLocation` 這二個 Property 來判斷

### 範例

假設設定了 ResourcesPath 為 `ABC`

```csharp
services.AddLocalization(options => options.ResourcesPath = "ABC")
```

當 Key 為 `Hello` 時，就可以查看 `IStringLocalizer<T>["Hello"]` 的內容

![AltMessage](./_images/Annotation&#32;2020-04-12&#32;110438.png)

- ResourceNotFound - 是否有找到 Resource File
- SearchedLocation - 從這個路徑來找 Resource File
