# 套用 jQuery Validate 的方式

```html
@section scripts
{
    <script src="~/Scripts/jquery.validate.min.js"></script>
    <script src="~/Scripts/jquery.validate.unobtrusive.min.js"></script>

    @* 如果有設定 Bundle 可以用以下的語法 *@
    @Scripts.Render("~/bundles/jqueryval")
} 
```