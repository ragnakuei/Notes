# [Antiforgery](https://docs.microsoft.com/zh-tw/aspnet/core/security/anti-request-forgery)

- 如果要做套用 Cross Domain Cookie 可參考[這](../Cookie/Cross%20Domain%20設定.md)

## 全域啟用

```csharp
services.AddAntiforgery();
```

## post 套用

使用 asp-antiforgery 來產生 key

```html
<form method="post" asp-antiforgery="true">
    <div asp-validation-summary="ModelOnly " class="text-danger"></div>
    <div class="form-group">
        <label asp-for="Name " class="col-sm-2 col-form-label"></label>
        <div class="col-sm-10">
            <input asp-for="Name " class="form-control">
            <span asp-validation-for="Name " class="text-danger"></span>
        </div>
    </div>

    <div class="form-group">
        <input type="submit" value="Submit" class="btn btn-primary"/>
    </div>
</form>
```
