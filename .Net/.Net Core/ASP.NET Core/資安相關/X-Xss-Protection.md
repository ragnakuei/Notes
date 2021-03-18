# X-Xss-Protection

```csharp
app.Use(async (context, next) =>
        {
            context.Response.Headers.Add("X-Xss-Protection", "1");

            await next();
        });
```
