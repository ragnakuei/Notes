# DI 的方式

[Per-request middleware dependencies](https://docs.microsoft.com/en-us/aspnet/core/fundamentals/middleware/write#per-request-middleware-dependencies)

直接把要 DI 的 instance 放在 `InvokeAsync()` 中

不要放在 constructor 中

例如下面的 `IService`

```csharp
public async Task InvokeAsync(HttpContext httpContext, IService service)
```

### 支援 Middleware Constructor DI 的 instance

-   ILogger\<T>
-   IMemoryCache
