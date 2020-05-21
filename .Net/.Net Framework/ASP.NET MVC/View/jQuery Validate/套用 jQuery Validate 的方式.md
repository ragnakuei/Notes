# 套用 jQuery Validate 的方式

View 所產生的 html attributes 的 `data-val` 開頭的項目是透過 `jquery.validate.unobtrusive` 去運作的

而 `jquery.validate.unobtrusive` 套件是由 `Microsoft.jQuery.Unobtrusive.Validation` 套件提供的

```html
@section scripts
{
    <script src="~/Scripts/jquery.validate.min.js"></script>
    <script src="~/Scripts/jquery.validate.unobtrusive.min.js"></script>

    @* 如果有設定 Bundle 可以用以下的語法 *@
    @Scripts.Render("~/bundles/jqueryval")
} 
```