# SPA

## 獨立執行 Angular

> 注意：需要手動設定 CORS

```csharp
app.UseSpa(spa =>
{
    // To learn more about options for serving an Angular SPA from ASP.NET Core,
    // see https://go.microsoft.com/fwlink/?linkid=864501

    spa.Options.SourcePath = "ClientApp";

    if (env.IsDevelopment())
    {
        // spa.UseAngularCliServer(npmScript: "start");
        spa.UseProxyToSpaDevelopmentServer("http://localhost:4200");
    }
});
```

[參考資料](https://docs.microsoft.com/zh-tw/aspnet/core/client-side/spa/angular?tabs=visual-studio)
