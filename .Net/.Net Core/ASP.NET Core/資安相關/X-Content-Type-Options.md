# X-Content-Type-Options

```csharp
app.Use(async (context, next) =>
        {
            context.Response.Headers.Add("X-Content-Type-Options", "nosniff");

            await next();
        });
```
