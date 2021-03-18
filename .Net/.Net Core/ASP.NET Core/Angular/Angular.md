# [Angular](https://docs.microsoft.com/zh-tw/aspnet/core/client-side/spa/angular)

- 欄位的 mapping 上都一律用小寫開頭。延伸到 Angular Material 的使用情境來說，property name 的命名也必須是小寫開頭。

- 如果要透過 environment.ts 來指定後端 host，預設指定 5000 就可以了

## 執行邏輯

- dotnet run 執行 asp.net core
- `Startups.cs`
  - `Configure()`
  - `spa.UseAngularCliServer(npmScript: "start")`
  - 於 `spa.Options.SourcePath = "ClientApp"` 所指定的目錄來執行 npm start
  - npm start 參考了 `package.json` > scripts 所指定的 start 來執行 `ng serve`
  - dotnet core 背後會自動處理以 websocket 來做前後端的連線，就可以不用設定 CORS

> 如果要以 [獨立執行 Angular](../SPA.md#獨立執行%20Angular)，就必須設定 [CORS](../CORS%20設定方式.md)
