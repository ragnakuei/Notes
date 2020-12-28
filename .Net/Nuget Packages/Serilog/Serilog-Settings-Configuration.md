# [Serilog-Settings-Configuration](https://github.com/serilog/serilog-settings-configuration)

## 讀取 appsettings.json
  - [範例](./console%20+%20Hosting%20範例.md)
  - 記得將檔案設定成 `copy to output directory`
  - IConfiguration `預設`就會讀取 apppsettings.json，不需要特別指定
  - 預設會讀取 appsettings.json 中的 Section `Serilog` 的結構
    - [可手動指定](#手動指定為-customsection)


### 手動指定為 CustomSection
```csharp
var logger = new LoggerConfiguration()
    .ReadFrom.Configuration(configuration, sectionName: "CustomSection")
    .CreateLogger();
```

```json
{
  "CustomSection": {
    // TODO
  }
}
```