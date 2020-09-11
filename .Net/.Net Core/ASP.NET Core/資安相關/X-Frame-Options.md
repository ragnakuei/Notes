# X-Frame-Options

用來阻擋被 iframe 嵌入

```csharp
app.Use(async (context, next) =>
        {
            context.Response.Headers.Add("X-Frame-Options", "DENY");

            await next();
        });
```
