# 套用至 Windows Form

```csharp
[STAThread]
static void Main()
{
    Application.EnableVisualStyles();
    Application.SetCompatibleTextRenderingDefault(false);

    var serviceProvider = BuildDIServiceProvider();
    Application.Run(serviceProvider.GetService<Form1>());
}

private static IServiceProvider BuildDIServiceProvider()
{
    var services = new ServiceCollection();
    services.AddSingleton<Form1>();
    services.AddTransient<ExcelMiddleware>();

    var serviceProvider = services.BuildServiceProvider();
    return serviceProvider;
}
```
