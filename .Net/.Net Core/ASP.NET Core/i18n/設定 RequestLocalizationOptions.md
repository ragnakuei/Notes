# 設定 RequestLocalizationOptions

設定這個之後，才會讀取 request Accept-Language

如果未設定時，預設會以 en-US 做為預設語系

---

## 範例一

1. 設定 RequestLocalizationOptions
1. 將 RequestLocalizationOptions 指定至 UseRequestLocalization 中

```csharp
public class Startup
{
    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    // This method gets called by the runtime. Use this method to add services to the container.
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddLocalization(options => options.ResourcesPath = "Resources");

        services.AddControllers();

        services.AddControllersWithViews()
                .AddViewLocalization()               // 設定這個就可以使用 IViewLocalizer DI 到 View 中
                .AddDataAnnotationsLocalization();   // 不加此行會讓 IStringLocalizer<T> 的 DI 無法判斷 Type 的來源

        // 1
        services.Configure<RequestLocalizationOptions>(
            options =>
            {
                // 設定預設的語系，如果 Request Header 指定 Accept-Language，會以該語系為主
                options.DefaultRequestCulture = new RequestCulture(culture: "zh-TW", uiCulture: "zh-TW");

                //  設定可支援的語系
                var supportedCultures = new List<CultureInfo>
                {
                    new CultureInfo("zh-TW"),
                    new CultureInfo("en-US"),
                };
                options.SupportedCultures = supportedCultures;
                options.SupportedUICultures = supportedCultures;
            });
    }

    // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (env.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
        }
        else
        {
            app.UseExceptionHandler("/Home/Error");
            // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
            app.UseHsts();
        }

        // 2
        // 將上面給定的 RequestLocalizationOptions 餵給 UseRequestLocalization
        var locOptions = app.ApplicationServices.GetService<IOptions<RequestLocalizationOptions>>();
        app.UseRequestLocalization(locOptions.Value);
    
        app.UseHttpsRedirection();
        app.UseStaticFiles();

        app.UseRouting();

        app.UseAuthorization();

        app.UseEndpoints(endpoints =>
        {
            endpoints.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}");
        });
    }
}
```

