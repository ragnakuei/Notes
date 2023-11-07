# 搭配啟動 Asp.Net Core 進行測試

目前測試的結果是，啟動 Asp.Net Core 

1. 要以 Asp.Net Core 3.1 含以前的版本的 Program.cs 的結構才行
1. 使用 Asp.Net Core 5.0 含以後版本的 Program.cs 的結構，會無法檢視頁面


假設 Asp.Net Core 5.0 含以後版本的 Program.cs 是

```cs
var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

// var host = app.Services.GetService<IHost>();
// host.Start();

app.Run();
```

在搭配 Playwright 進行測試時，可以改為以下的結構

```cs
public class Program
{
    private static async Task Main(string[] args)
    {
        var host = BuildWebHost(args);
        await host.RunAsync();
    }

    public static IHost BuildWebHost(string[]? args = default)
        => Host.CreateDefaultBuilder(args)
               .ConfigureWebHostDefaults(builder =>
                {
                    builder.UseStaticWebAssets();
                    builder.UseStartup<Startup>();
                })
               .Build();
}

public class Startup
{
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddControllersWithViews();
    }

    public virtual void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        // Configure the HTTP request pipeline.
        if (!env.IsDevelopment())
        {
            app.UseExceptionHandler("/Home/Error");

            // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
            app.UseHsts();
        }

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

在 NUnit 的 Test Case 中，可以使用以下的方式進行測試，原本需要繼承 PageTest 的就改為繼承 AspNetMvcPageTest

```cs
public abstract class AspNetMvcPageTest : PageTest
{
    protected IHost Host { get; private set; } = null!;

    protected string HostAddress => Host.Services
                                        .GetRequiredService<IServer>()
                                        .Features
                                        .GetRequiredFeature<IServerAddressesFeature>()
                                        .Addresses
                                        .Single();

    protected Uri RootUri => new Uri(HostAddress);

    [OneTimeSetUp]
    public async Task Setup()
    {
        Host = Program2.BuildWebHost();
        await Host.StartAsync();
    }

    [OneTimeTearDown]
    public async Task TearDown()
    {
        await Host.StopAsync();
    }
}
```


待測項目：

- 測試 RunAsync 與 StartAsync 的差異