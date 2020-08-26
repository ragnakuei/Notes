# add header Content-Security-Policy

## 注意事項

-   套用 csp 後，會無法直接使用 inline css
    -   就是無法在 cshtml 內使用 \<style><\style>
    -   可以改用 css file

## 參考資料

-   [Content Security Policy Directives](https://w3c.github.io/webappsec-csp/#csp-directives)
-   [[鐵人賽 Day27] ASP.NET Core 2 系列 - 網頁內容安全政策 (Content Security Policy)](https://blog.johnwu.cc/article/ironman-day27-asp-net-core-content-security-policy.html)

## 語法

```csharp
app.UseCsp(options =>
            {
                // 最通用的設定方式
                options.Defaults.AllowSelf();

                // 這樣連自己的網頁都會無法存取
                options.Defaults.Disallow();

                // 其他的範例
                options.Styles.Allow("https:");
                options.Images.AllowSelf();
                options.Frames.Disallow();
                options.Scripts.AllowSelf();
            });
```

```csharp
public class CspDirective
{
    private readonly string _directive;

    internal CspDirective(string directive)
    {
        _directive = directive;
    }

    private List<string> _sources { get; set; } = new List<string>();

    public virtual CspDirective AllowAny()  => Allow("*");
    public virtual CspDirective Disallow()  => Allow("'none'");
    public virtual CspDirective AllowSelf() => Allow("'self'");

    public virtual CspDirective Allow(string source)
    {
        _sources.Add(source);
        return this;
    }

    public override string ToString() => _sources.Count > 0
                                                ? $"{_directive} {string.Join(" ", _sources)}; "
                                                : "";
}

public class CspOptions
{
    public bool         ReadOnly    { get; set; }
    public CspDirective Childs      { get; set; } = new CspDirective("child-src");
    public CspDirective Connects    { get; set; } = new CspDirective("connect-src");
    public CspDirective Defaults    { get; set; } = new CspDirective("default-src");
    public CspDirective Fonts       { get; set; } = new CspDirective("font-src");
    public CspDirective Frames      { get; set; } = new CspDirective("frame-src");
    public CspDirective Images      { get; set; } = new CspDirective("img-src");
    public CspDirective Manifests   { get; set; } = new CspDirective("manifest-src");
    public CspDirective Media       { get; set; } = new CspDirective("media-src");
    public CspDirective Objects     { get; set; } = new CspDirective("object-src");
    public CspDirective Scripts     { get; set; } = new CspDirective("script-src");
    public CspDirective ScriptElems { get; set; } = new CspDirective("script-src-elem");
    public CspDirective ScriptAttrs { get; set; } = new CspDirective("script-src-attr");
    public CspDirective Styles      { get; set; } = new CspDirective("style-src");
    public CspDirective StyleElems  { get; set; } = new CspDirective("style-src-elem");
    public CspDirective StyleAttrs  { get; set; } = new CspDirective("style-src-attr");
    public CspDirective Workers     { get; set; } = new CspDirective("worker-src");

    public string ReportURL { get; set; }
}

public class CspMiddleware
{
    private readonly RequestDelegate _next;
    private readonly CspOptions      _options;

    public CspMiddleware(RequestDelegate next, CspOptions options)
    {
        _next    = next;
        _options = options;
    }

    public async Task Invoke(HttpContext context)
    {
        context.Response.Headers.Add(Header, HeaderValue);
        await _next(context);
    }

    private string Header => _options.ReadOnly
                                    ? "Content-Security-Policy-Report-Only"
                                    : "Content-Security-Policy";

    private string HeaderValue
    {
        get
        {
            var stringBuilder = new StringBuilder();
            stringBuilder.Append(_options.Defaults);
            stringBuilder.Append(_options.Connects);
            stringBuilder.Append(_options.Fonts);
            stringBuilder.Append(_options.Frames);
            stringBuilder.Append(_options.Images);
            stringBuilder.Append(_options.Media);
            stringBuilder.Append(_options.Objects);
            stringBuilder.Append(_options.Scripts);
            stringBuilder.Append(_options.Styles);
            if (!string.IsNullOrEmpty(_options.ReportURL))
            {
                stringBuilder.Append($"report-uri {_options.ReportURL};");
            }

            return stringBuilder.ToString();
        }
    }
}

public static class CspMiddlewareExtensions
{
    public static IApplicationBuilder UseCsp(this IApplicationBuilder app, CspOptions options)
    {
        return app.UseMiddleware<CspMiddleware>(options);
    }

    public static IApplicationBuilder UseCsp(this IApplicationBuilder app, Action<CspOptions> optionsDelegate)
    {
        var options = new CspOptions();
        optionsDelegate(options);
        return app.UseMiddleware<CspMiddleware>(options);
    }
}
```
