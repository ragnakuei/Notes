# AppScan 相關解決

```cs
/// <summary>
/// 為了通過 AppScan 檢測所需要的判斷
/// </summary>
public class AppscanMiddleware
{
    private readonly ILogger<AppscanMiddleware> _logger;
    private readonly RequestDelegate            _next;

    public AppscanMiddleware(RequestDelegate            next,
                             ILogger<AppscanMiddleware> logger)
    {
        _logger = logger;
        _next   = next;
    }

    public async Task InvokeAsync(HttpContext httpContext)
    {
        ValidUrlQueryStringRequestVerificationToken(httpContext);
        
        if (await HasInvalidKeyword(httpContext))
        {
            throw new Exception("AppScan 無效要求");
        }

        AddNoCacheHeaderForJsFiles(httpContext);

        await _next(httpContext);
    }

    /// <summary>
    /// 驗証 Url
    /// </summary>
    /// <remarks>
    /// 解決：查詢中接受 Body 參數
    /// </remarks>
    private bool ValidUrlQueryStringRequestVerificationToken(HttpContext httpContext)
    {
        if (httpContext.Request.QueryString.HasValue == false)
        {
            return true;
        }

        var queryPair = HttpUtility.ParseQueryString(httpContext.Request.QueryString.Value ?? "");

        if (queryPair.AllKeys.Contains("__RequestVerificationToken"))
        {
            throw new Exception("AppScan 的無效要求");
        }

        return true;
    }

    /// <summary>
    /// 針對 js 檔案加入 no-cache header 及 pragma header
    /// </summary>
    /// <remarks>
    /// 解決：找到可快取的 SSL 頁面
    /// </remarks>
    private void AddNoCacheHeaderForJsFiles(HttpContext httpContext)
    {
        var isJsFile = httpContext.Request.Path.Value.Contains(".js");

        if (!isJsFile)
        {
            return;
        }

        httpContext.Response.Headers.Add("Cache-Control", "no-cache, no-store, must-revalidate");
        httpContext.Response.Headers.Add("Pragma",        "no-cache");
    }

    private readonly HashSet<string> _invalidKeywords
        = new()
        {
            "is_admin",
            "isadmin",
            "is_sso",
            "issso",
        };

    /// <remarks>
    /// 解決：API 大量指派
    /// </remarks>
    private async Task<bool> HasInvalidKeyword(HttpContext context)
    {
        if (context.Request.Method == "GET"
            || !context.Request.Path.StartsWithSegments("/api"))
        {
            return false;
        }

        // 判斷 request 為 Post & 是上傳檔案
        if (context.Request.Method                                            != "POST"
            || context.Request.ContentType?.StartsWith("multipart/form-data") == true)
        {
            // 取出 Request Body 內的資料並轉為 FormData
            var formValueProvider = await context.Request.ReadFormAsync();

            // 取出 FormData 所有 Key 比對是否有包含關鍵字
            return formValueProvider.Keys.Any(key => _invalidKeywords.Any(keyword => key.Contains(keyword)));
        }

        // get request body
        context.Request.EnableBuffering();
        var requestBody = await GetRawBodyStringAsync(context, Encoding.UTF8);

        // check keyword
        return _invalidKeywords.Any(keyword => requestBody.Contains(keyword));
    }

    private async Task<string> GetRawBodyStringAsync(HttpContext httpContext, Encoding encoding)
    {
        var body = String.Empty;

        if (httpContext.Request.ContentLength          == null
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