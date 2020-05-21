# AntiForgeryTokenWithPrefixName

因應需要把 `__RequestVerificationToken` 一併透過 jQuery.Validate post 回傳至後端  
但因為 mvc remote 所套用的 jQuery.Validate 會加上 model name  
所以就會需要這個 html helper

但是因為 `__RequestVerificationToken` 加上 prefix 後，會讓原本的 Attribute `ValidateAntiForgeryToken` 吃不到  
所以還會需要加上這個動作

### Html Helper

```csharp
public static class AntiForgeryTokenWithNameHelper
{
    public static MvcHtmlString AntiForgeryTokenWithPrefixName(this HtmlHelper helper, string namePrefix)
    {
        var html = AntiForgery.GetHtml();
        var fixedName = "__RequestVerificationToken";
        var result = html.ToString().Replace(fixedName, $"{namePrefix}.{fixedName}");
        return new MvcHtmlString(result);
    }
}
```

### 使用方式

```csharp
@{
    var newRole = new RoleValidateModel();
}

@Html.AntiForgeryTokenWithPrefixName(nameof(newRole))
```