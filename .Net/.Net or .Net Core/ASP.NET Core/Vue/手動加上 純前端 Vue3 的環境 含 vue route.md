# 手動加上 前端 Vue3 的環境 含 vue route

參考資料

- [Vue CLI 和 ASP.NET Core Web API 專案整合步驟](https://poychang.github.io/vue-cli-with-dotnet-core-api/)

注意：
> 本範例沒有要安裝 `Microsoft.AspNetCore.SpaServices.Extensions` 這個套件 !


## 實用 - 通用部份

1. 專案檔新增 TypeScriptCompileBlocked 讓 VS 不會對 ts 進行編譯

    > 這個設定是給 Visual Studio 用，Rider 不需要 !

    ```xml
    <PropertyGroup>
        <TargetFramework>net5.0</TargetFramework>
        <CopyRefAssembliesToPublishDirectory>false</CopyRefAssembliesToPublishDirectory>
        <TypeScriptCompileBlocked>true</TypeScriptCompileBlocked>
    </PropertyGroup>
    ```

1. 新增 Middleware

    ```csharp
    public static class SpaExtensions
    {
        public static IApplicationBuilder UseSpaStaticFiles(this IApplicationBuilder builder)
        {
            return builder.UseMiddleware<SpaMiddleware>();
        }
    }

    public class SpaMiddleware
    {
        private readonly RequestDelegate _next;

        public SpaMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task Invoke(HttpContext context)
        {
            await _next.Invoke(context);

            if (context.Response.StatusCode == 404                          // 該資源不存在
                && Path.HasExtension(context.Request.Path.Value) == false   // 網址最後沒有帶副檔名
                && context.Request.Path.Value.StartsWith("/api") == false ) // 網址不是 /api 開頭（不是發送 API 需求）
            {
                context.Request.Path        = "/index.html";                // 將網址改成 /index.html
                context.Response.StatusCode = 200;                          // 並將 HTTP 狀態碼修改為 200 成功

                await _next.Invoke(context);
            }
        }
    }
    ```


## 實作 ( After Asp.Net Core 6.0 )

1. Program.cs

    ```cs
    using AspNetCoreWebAPI_Vue.Infra;

    var builder = WebApplication.CreateBuilder(args);

    // Add services to the container.

    builder.Services.AddControllers();
    // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
    builder.Services.AddEndpointsApiExplorer();
    builder.Services.AddSwaggerGen();

    var app = builder.Build();

    // Configure the HTTP request pipeline.
    if (app.Environment.IsDevelopment())
    {
        app.UseSwagger();
        app.UseSwaggerUI();
    }

    app.UseHttpsRedirection();
    app.UseAuthorization();
    
    // 一定要放在 UseStaticFiles 之前
    app.UseMiddleware<SpaMiddleware>();

    app.UseStaticFiles();

    app.MapControllers();

    app.Run();

    ```



## 實作 ( Before Asp.Net Core 5.0 )


1. Startup.cs > Configure() 加上以下語法:

    ```csharp
    app.UseSpaStaticFiles();

    var defaultFilesOptions = new DefaultFilesOptions();
    defaultFilesOptions.DefaultFileNames.Clear();
    defaultFilesOptions.DefaultFileNames.Add("index.html");
    app.UseDefaultFiles(defaultFilesOptions);

    new[]
        {
            // 為了給 index.html 讀取用的
            new { PhysicalPath = new[] { env.ContentRootPath, "wwwroot" }, UrlPath = "" },

            new { PhysicalPath = new[] { env.ContentRootPath, "wwwroot", "js" }, UrlPath  = "/js" },
            new { PhysicalPath = new[] { env.ContentRootPath, "wwwroot", "css" }, UrlPath = "/css" },
            new { PhysicalPath = new[] { env.ContentRootPath, "wwwroot", "lib" }, UrlPath = "/lib" },
            new { PhysicalPath = new[] { env.ContentRootPath, "wwwroot", "vue" }, UrlPath = "/vue" },
        }
        .ForEach(dto => app.UseStaticFiles(new StaticFileOptions()
                                            {
                                                FileProvider = new PhysicalFileProvider(Path.Combine(dto.PhysicalPath)),
                                                RequestPath  = new PathString(dto.UrlPath)
                                            }));
    ```

1. 新增 index.html

    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Vue module 試作</title>
        <!-- Vue -->
        <script src="/lib/vue/3.2.11/vue.global.min.js"></script>
        <script src="/lib/vue-router/4.0.11/vue-router.global.js"></script>

        <link rel="stylesheet" href="/css/site.css">
        <!-- Bootstrap -->
        <link rel="stylesheet" href="/lib/bootstrap/5.1.1/css/bootstrap.min.css">
        <script src="lib/bootstrap/5.1.1/js/bootstrap.min.js" ></script>
    </head>
    <body>
    <div id="app" v-cloak></div>
    <script type="module">
        import app from '/vue/app.js'
        import router from '/vue/router.js'
        // import store from '/vue/store.js'

        const { createApp } = Vue;

        createApp(app).use(router)
            // .use(store)
            .mount('#app');
    </script>
    </body>
    </html>
    ```

1. 其餘檔案在[這](https://github.com/ragnakuei/AspNetCoreVueRouteAndModuleAndVueFile)
   - 也可以參考[這](https://github.com/ragnakuei/AspNetCoreVueRouteAndModule) 
1. 驗証結果
   - 在 vue 切到不同 route 後，直接按下 F5 ，要可以回到原本的頁面

