# IHtmlHelper

Extension

```cs
public static class HtmlHelperExtensions
{
    public static IHtmlContent Json(this IHtmlHelper       htmlHelper,
                                    object                 obj,
                                    JsonSerializerOptions? jsonSerializerOptions = null)
    {
        var json = JsonSerializer.Serialize(obj, jsonSerializerOptions);

        // return htmlHelper.Raw(json);
        return new HtmlString(json);
    }
}
```

使用方式

```cs
@{
    var obj = new { Name = "測試一二三", Age = 30 };
}
@Html.Json(obj)
```
