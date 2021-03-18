# console 範例

要把 json 檔複製至輸出目錄

## 取單一值

appsettings.json

```json
{
  "Test" : "A"
}
```

```csharp
var configurationRoot = new ConfigurationBuilder()
                        .AddJsonFile("appsettings.json", false, true)
                        .Build();

// var result = configurationRoot["Test"];   // 這個方式也可以
var result = configurationRoot.GetSection("Test").Value;

Console.WriteLine(result);
```

## 取 object 內的單一值

appsettings.json

```json
{
  "A" : {
    "A1" : "Test"
  }
}
```

以 : 來間隔每層 property 的名稱

```csharp
var _configurationRoot = new ConfigurationBuilder()
                        .AddJsonFile("appsettings.json", false, true)
                        .Build();

var result = _configurationRoot.GetSection("A:A1").Value;

Console.WriteLine(result);
```
