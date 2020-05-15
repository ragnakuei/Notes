# AddViewLocalization

設定這個就可以使用 IViewLocalizer DI 到 View 中

```csharp
services.AddControllersWithViews()
        .AddViewLocalization()               // 設定這個就可以使用 IViewLocalizer DI 到 View 中
```