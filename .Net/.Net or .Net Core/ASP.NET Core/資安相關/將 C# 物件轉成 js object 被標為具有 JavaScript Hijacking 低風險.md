# 將 C# 物件轉成 js object 被標為具有 JavaScript Hijacking 低風險

原先的寫法

```cs
@{
    var data = new List<T>();
}

<script>
    const data = @Html.Raw(Data.ToJson());
</script>
```

---

原因分析

-   只要該資料從 DB 取出，透過 Html.Raw() 放至頁面的 js 中，都會被 Checkmarx 視為 JavaScript Hijacking 低風險

---

解法

先將 C# object 轉成 Json 後，放在 html dom 的 attribute 上
再從 js 取出，並以 JSON.parse() 來解析 !

```html
<div
    data-json1="@obj1.ToJson()"
    data-json2="@obj2.ToJson()"
    id="myData"
    class="visually-hidden"
>
    Test
</div>

<script>
    // 將 dom 指定的 attributes 轉成 js objects
    window.parseJsonFromHtmlAttributesToJsObjects = (
        domSelector,
        attributeArray,
    ) => {
        const objArray = [];
        const dom = document.querySelector(domSelector);

        if (!dom) {
            console.error('dom not found', domSelector);
        }

        for (const attribute of attributeArray) {
            const htmlEncodedJson = dom.getAttribute(attribute);

            if (!htmlEncodedJson) {
                console.trace(
                    `attribute:${attribute} not found in specify dom`,
                    dom,
                );
            }

            const jsObj = JSON.parse(htmlEncodedJson);
            objArray.push(jsObj);
        }

        return objArray;
    };

    const [obj1, obj2] = parseJsonFromHtmlAttributesToJsObjects('#myData', [
        'data-json1',
        'data-json2',
    ]);

    console.log(obj1);
    console.log(obj2);
</script>
```

搭配 HtmlSanitizer 的 IHtmlHelper 擴充方法

```cs
public static class HtmlHelperExtensions
{
    public static IHtmlContent Sanitize(this IHtmlHelper htmlHelper,
                                        string?          input)
    {
        var sanitize = new HtmlSanitizer().Sanitize(input);
        return new HtmlString(sanitize);
    }

    public static IHtmlContent Content(this IHtmlHelper htmlHelper,
                                       string?          input)
    {
        return new HtmlString(input);
    }

    public static IHtmlContent SanitizeJson(this IHtmlHelper htmlHelper,
                                            object?          input)
    {
        var json = input?.ToJson() ?? string.Empty;

        var sanitize = new HtmlSanitizer().Sanitize(json);
        return new HtmlString(sanitize);
    }
}
```
