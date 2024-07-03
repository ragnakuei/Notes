# 將 C# Object 轉成 JS Object 的最安全做法

號稱 & 經過測，為目前最安全的做法 !

測試來源：

[XSS Payload](https://github.com/payloadbox/xss-payload-list)

.cshtml 中，obj 的內容如下：

```cs
@{
    var txtPath    = AppDomain.CurrentDomain.BaseDirectory + "XssPayload.txt";
    var xssPayload = System.IO.File.ReadAllText(txtPath);
    var obj = new
                {
                    Name       = "測試一二<p>三四五</p> &lt;script&gt;alert(&#39;ok&#39;);&lt;/script&gt; <script>alert('ok');</script> <b onmouseover=alert(‘XSS testing!‘)>OnMouseOver</b>",
                    Age        = 30,
                    XssPayload = xssPayload,
                };
}
```

原先的想法：

> 經過 @ 的結果就是經過 HtmlEncode 的字串
> Html.Raw 的結果就是不經過 HtmlEncode 的字串

第一次整理想法：

> 不想使用 Html.Raw 但要使用 @ 才能將內容顯示至 Html 中
> 那就只能想辦法將內容先用 @ 將內容 轉成 JSON > 做 Sanitize > 做 HtmlEncode， 在 JS 去 HtmlDecode
> 但 HtmlDecode 後是字串，所以要再使用 JSON.parse 去解析成 JS 物件

```js
const obj = JSON.parse(HtmlDecode('@obj.ToJson().Sanitize()'));
console.log(obj);
```

第一次想法測試結果：

> 在 JS 做 HtmlDecode 時，就會立即執行 XSS 攻擊，JS HtmlDecode 實作方法有 XSS 風險

```js
// 有 XSS 風險
function HtmlDecode(input) {
    const e = document.createElement('div');
    e.innerHTML = input;
    return e.childNodes.length === 0 ? '' : e.childNodes[0].nodeValue;
}
```

第二次整理想法：

> 改用新的 JS HtmlDeocde 方法

```js
// 雖無 XSS 風險，但執行失敗
function HtmlDecode(encodedString) {
    const parser = new DOMParser();
    const dom = parser.parseFromString(
        `<!doctype html><body>${encodedString}`,
        'text/html',
    );
    return dom.body.textContent;
}
```

第二次想法測試結果：

> 目前找不到適合做 JS HtmlDecode 的方法

第三次整理想法：

> 直接將 JSON 字串放在 HTML 中，然後在 JS 中取出來

```html
<div
    data-json1="@obj.ToJson()"
    data-json2="@obj.ToJson()"
    id="json"
    class="visually-hidden"
>
    Test
</div>
```

```js
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

const [obj1, obj2] = parseJsonFromHtmlAttributesToJsObjects('#json', [
    'data-json1',
    'data-json2',
]);
console.log(obj1);
console.log(obj2);
```

第三次想法測試結果：

> 已照預期執行

最終做法整理：

> 將 C# object instance 轉成 JSON 字串後，放在 HTML 的 data-\* 屬性中，然後在 JS 中取出來，再使用 JSON.parse 轉成 JS 物件
