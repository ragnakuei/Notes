# 範例一 - 以 alert 顯示錯誤訊息

## Dto 定義

-   `{0}` 所指的都是 Display.Name

```csharp
public class TestDto
{
    [Display(Name = "編號")]
    [Required(ErrorMessage    = "沒填是要怎麼抓資料")]
    [Range(1, 5, ErrorMessage = "{0} 數值 要介於 {1} 及 {2} 之間")]
    public int? Id { get; set; }

    [Display(Name = "名稱")]
    [DataType(DataType.Text)]
    [Required(ErrorMessage         = "請輸入{0}")]
    [StringLength(5, MinimumLength = 2, ErrorMessage = "{0} 長度 要介於 {2} 及 {1} 之間")]
    public string Name { get; set; }

    [Display(Name = "電子信箱")]
    [DataType(DataType.EmailAddress)]
    [Required(ErrorMessage     = "必填喔")]
    [EmailAddress(ErrorMessage = "為何不填 Email 格式")]
    public string Email { get; set; }
}
```

## Action 範例

此範例把 驗証結果 放到 `TempData["ValidMessage"]` 中，可視情況調整 !

```csharp
[HttpPost]
[ValidateAntiForgeryToken]
public IActionResult Index(TestDto dto)
{
    if (ModelState.IsValid == false)
    {
        TempData["ValidMessage"] = JsonSerializer.Serialize(ModelState.ToDictionary().ReplaceKeyToDisplayName<TestDto>());
        return View(dto);
    }

    TempData["ValidMessage"] = "驗証成功";
    return RedirectToAction("Index");
}
```

## Helpers 範例

```csharp
public static class ModelStateHelper
{
    public static Dictionary<string, List<string>> ToDictionary(this ModelStateDictionary m)
    {
        var result = new Dictionary<string, List<string>>();

        if (m.IsValid)
        {
            return result;
        }

        foreach (var keyValuePair in m)
        {
            result.Add(keyValuePair.Key, keyValuePair.Value.Errors.Select(e => e.ErrorMessage).ToList());
        }

        return result;
    }

    public static Dictionary<string, List<string>> ReplaceKeyToDisplayName<T>(this Dictionary<string, List<string>> dict)
    {
        var propertiesDisplayNames = typeof(T).GetProperties()
                                                .Select(p => new
                                                            {
                                                                PropertyName     = p.Name,
                                                                DisplayAttribute = p.GetCustomAttributes(typeof(DisplayAttribute), false)?.FirstOrDefault() as DisplayAttribute
                                                            })
                                                .ToDictionary(k => k.PropertyName, v => v.DisplayAttribute.Name);

        var result = dict.Select(kv =>
                                        new
                                        {
                                            NewKey = propertiesDisplayNames.GetValue(kv.Key),
                                            Value  = kv.Value,
                                        })
                            .ToDictionary(kv => kv.NewKey, kv => kv.Value);

        return result;
    }
}
```

## View

```csharp
@model TestDto
@{
    ViewData["Title"] = "Home Page";
}

<h1>Home</h1>

<form method="post" enctype="multipart/form-data">
    <p>
        <label asp-for="Id"></label>
        <input asp-for="Id" />
    </p>
    <p>
        <label asp-for="Name"></label>
        <input asp-for="Name" />
    </p>
    <p>
        <label asp-for="Email"></label>
        <input asp-for="Email" />
    </p>
    <p>
        <label asp-for="UploadFile"></label>
        <input asp-for="UploadFile" />
    </p>
    <p>
        <label asp-for="UploadFile"></label>
        <input asp-for="UploadFile" />
    </p>
    <p>
        <input type="submit"
               value="Submit" />
    </p>
</form>

@section Scripts {
    <script>
    window.ValidMessage = '@(Html.Raw(TempData["ValidMessage"]?.ToString()))';
    if(ValidMessage.length > 0)
    {
        alert(ValidMessage);
    }
</script>
}
```
