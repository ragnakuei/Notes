# checkbox

觀念：
- 有多少選項放到 checkbox 中，Post 時，就會接到多少 選項
- 選項可以用自訂的 ViewModel

### 手指指定簡單範例

```csharp
[HttpGet]
public IActionResult Index()
{
    var vm = new Test2ViewModel
                {
                    Filters = new[]
                            {
                                new SelectListItem { Text = "A", Value = "vA" },
                                new SelectListItem { Text = "B", Value = "vB" },
                                new SelectListItem { Text = "C", Value = "vC" },
                                new SelectListItem { Text = "D", Value = "vD" },
                                new SelectListItem { Text = "E", Value = "vE" },
                            }
                };
    return View(vm);
}

[HttpPost]
public IActionResult PostIndex(Test2ViewModel vm)
{
    return View("Index", vm);
}
```

```csharp
public class Test2ViewModel
{
    public string[] SelectedValues { get; set; }

    public SelectListItem[] Filters { get; set; }
}
```

View

```csharp
@model CheckBoxPractice.Controllers.Test2ViewModel

<form method="post"
      asp-action="PostIndex">

    @for (var index = 0; index < Model.Filters.Length; index++)
    {
        <p>
            <input type="checkbox"
                   name="SelectedValues"
                   id="Filters@(index)"
                   value="@(Model.Filters[index].Value)" />
            <label for="Filters@(index)">@(Model.Filters[index].Text)</label>
        </p>
    }

    <input type="submit"
           value="Sumbit" />
</form>

```

### 複雜型別範例 - 可指定勾選項目

選項 ViewModel

```csharp
public class CheckBoxViewModel
{
    public bool Selected { get; set; }

    public string Value { get; set; }

    public string Text { get; set; }
}
```

```csharp
[HttpGet]
public IActionResult Index()
{
    var vm = new TestViewModel
                {
                    Filters = new[]
                            {
                                new CheckBoxViewModel { Value = "11", Selected = true, Text = "A1", },
                                new CheckBoxViewModel { Value = "12", Selected = true, Text = "A2", },
                                new CheckBoxViewModel { Value = "13", Selected = true, Text = "A3", },
                                new CheckBoxViewModel { Value = "14", Selected = true, Text = "A4", },
                                new CheckBoxViewModel { Value = "15", Selected = true, Text = "A5", },
                                new CheckBoxViewModel { Value = "21", Selected = true, Text = "B1", },
                                new CheckBoxViewModel { Value = "22", Selected = true, Text = "B2", },
                                new CheckBoxViewModel { Value = "23", Selected = true, Text = "B3", },
                                new CheckBoxViewModel { Value = "24", Selected = true, Text = "B4", },
                                new CheckBoxViewModel { Value = "25", Selected = true, Text = "B5", },
                            }
                };
    return View(vm);
}

[HttpPost]
public IActionResult PostIndex(TestViewModel vm)
{
    return RedirectToAction("Index");
}

public class TestViewModel
{
    public CheckBoxViewModel[] Filters { get; set; }
}
```

View

```html
@model CheckBoxPractice.Controllers.TestViewModel

<form method="post"
      asp-action="PostIndex">

    @for (var index = 0; index < Model.Filters.Length; index++)
    {
        <p>
            <input type="checkbox"
                   asp-for="@(Model.Filters[index].Selected)" />
            <label asp-for="@(Model.Filters[index].Selected)">@(Model.Filters[index].Text)</label>

            @* 如果想把 Text 也接回來，可以再加上 對應的 hidden input ! *@
            <input type="hidden"
                   asp-for="@Model.Filters[index].Value" />
        </p>
    }

    <input type="submit"
           value="Sumbit" />
</form>

```