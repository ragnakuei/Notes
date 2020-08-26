# Referrer-Policy

```csharp
app.Use(async (context, next) =>
        {
            context.Response.Headers.Add("Referrer-Policy",        "no-referrer");

            await next();
        });
```
