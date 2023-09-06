# 與個 Asp.Net Core 框架的搭配

目前測試的狀況如下：

1. Asp.Net Core Razor Pages
    1. 預設會啟用 CSRF Token 驗證
    1. 驗證失敗時，會直接產生 400 Bad Request，無法被 middleare 以 Exception 方式攔截
1. Asp.Net Core MVC
    1. 預設不會啟用 CSRF Token 驗證
    1. 可自由搭配，彈性較高
1. Asp.Net Core Web API
    1. 預設不會啟用 CSRF Token 驗證
    1. 可自由搭配，彈性較高


## Asp.Net Core Razor Pages

### 停用 CSRF Token 驗證

在 Program.cs 裡面加入以下程式碼：

```csharp
builder.Services.AddRazorPages()
    .AddRazorPagesOptions(options =>
    {
        options.Conventions.ConfigureFilter(new IgnoreAntiforgeryTokenAttribute());
    });

// ... 

var app = builder.Build();

// ... 

app.MapRazorPages();
```


## Asp.Net Core MVC

### 啟用 CSRF Token 驗證

在 Program.cs 裡面加入以下程式碼：

```csharp
builder.Services.AddControllersWithViews()
    .AddMvcOptions(options =>
    {
        options.Filters.Add(new AutoValidateAntiforgeryTokenAttribute());
    });

// ...

var app = builder.Build();

// ...

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");
```