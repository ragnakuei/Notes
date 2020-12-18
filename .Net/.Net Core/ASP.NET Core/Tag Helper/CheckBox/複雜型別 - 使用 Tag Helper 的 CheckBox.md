# 複雜型別 - 使用 Tag Helper 的 CheckBox

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