# 直接 Render Html

在 .Net 8 中介紹的

```cs
var services = new ServiceCollection();
services.AddLogging();

IServiceProvider serviceProvider = services.BuildServiceProvider();
ILoggerFactory loggerFactory = serviceProvider.GetRequiredService<ILoggerFactory>();

await using var htmlRender = new HtmlRender(serviceProvider, loggerFactory);
var html await = await htmlRender.Dispatcher.InvokeAsync( async () =>
{
    var output = await htmlRender.RenderComponentAsync<MyComponent>(ParameterView.Empty);
    return output.ToHtmlString();
}
```