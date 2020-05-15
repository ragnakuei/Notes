# [Razor file compilation in ASP.NET Core](https://docs.microsoft.com/zh-tw/aspnet/core/mvc/views/view-compilation)

讓 Razor files enable `runtime compilation`

## 安裝套件

> Microsoft.AspNetCore.Mvc.Razor.RuntimeCompilation

## Startups.cs

```csharp
public void ConfigureServices(IServiceCollection services)
{
    services.AddControllersWithViews()
    
            // 加上以下這行
            .AddRazorRuntimeCompilation();
}
```

