# middleware 讀取 request body 的情境

-   透過 await reader.ReadToEndAsync() 讀取出來
-   再將 httpContext.Request.Body.Position 歸 0 即可 !

```csharp
/// <summary>
/// 判斷 SqlInjection - 不判斷檔案上傳
/// </summary>
public class SqlInjectionMiddleware
{
    public SqlInjectionMiddleware(RequestDelegate                   next,
                                    SqlInjectionValidateStringService sqlInjectionValidateStringService)
    {
        _next                              = next;
        _sqlInjectionValidateStringService = sqlInjectionValidateStringService;
    }

    private readonly RequestDelegate                   _next;
    private readonly SqlInjectionValidateStringService _sqlInjectionValidateStringService;

    private readonly HashSet<string> _validateRequestBodyHttpMethods = new[] { "Post", "Patch", "Put" }.ToHashSet();

    public async Task Invoke(HttpContext context)
    {
        ValidateQueryString(context);

        if (_validateRequestBodyHttpMethods.Contains(context.Request.Method, StringComparer.CurrentCultureIgnoreCase)
            && string.IsNullOrWhiteSpace(context.Request.ContentType)      == false
            && context.Request.ContentType.Contains("multipart/form-data") == false)
        {
            await ValidateRequestBodyAsync(context);
        }

        await _next(context);
    }

    /// <summary>
    /// 檢查 Query String
    /// </summary>
    private void ValidateQueryString(HttpContext context)
    {
        var queryString = context.Request.QueryString.ToString();

        _sqlInjectionValidateStringService.Validate(queryString);
    }

    /// <summary>
    /// 檢查 Request Body
    /// </summary>
    private async Task ValidateRequestBodyAsync(HttpContext context)
    {
        context.Request.EnableBuffering();

        var body = await GetRawBodyStringAsync(context, Encoding.UTF8);

        _sqlInjectionValidateStringService.Validate(body);
    }

    private async Task<string> GetRawBodyStringAsync(HttpContext httpContext, Encoding encoding)
    {
        var body = String.Empty;

        if (httpContext.Request.ContentLength       == null
            || (httpContext.Request.ContentLength > 0) == false
            || httpContext.Request.Body.CanSeek        == false)
        {
            return body;
        }

        httpContext.Request.Body.Seek(0, SeekOrigin.Begin);
        using (var reader = new StreamReader(httpContext.Request.Body,
                                                encoding,
                                                true,
                                                1024,
                                                true))
        {
            body = await reader.ReadToEndAsync();
        }

        httpContext.Request.Body.Position = 0;
        return body;
    }
}
```
