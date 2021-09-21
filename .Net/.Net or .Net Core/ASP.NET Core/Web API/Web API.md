# [Web API](https://docs.microsoft.com/zh-tw/aspnet/core/web-api/)

- [Web API](#web-api)
  - [設定](#%e8%a8%ad%e5%ae%9a)

---

## 設定

```csharp
public class Startup
{
    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddControllers();  // 1
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (env.IsDevelopment())   // 2
        {
            app.UseDeveloperExceptionPage();
        }

        app.UseHttpsRedirection();

        app.UseRouting();   // 3

        app.UseAuthorization();

        app.UseEndpoints(endpoints =>         // 4
        {
            endpoints.MapControllers();
        });
    }
}
```
