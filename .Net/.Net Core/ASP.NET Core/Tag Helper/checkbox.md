# checkbox

觀念：
- 有多少選項放到 checkbox 中，Post 時，就會接到多少 選項
- 選項可以用自訂的 ViewModel

## 以父類群組化的 Checkbox

### 手動指定簡單範例

選單的父類跟子類關聯

```csharp
public class DtoA
{
    public int Id { get; set; }

    public string Name { get; set; }

    public DtoB[] DtoBs { get; set; }
}

public class DtoB
{
    public int Id { get; set; }

    public string Name { get; set; }
}
```

```csharp
[HttpGet]
public IActionResult Index()
{
    SetViewBagDtoAs();

    var vm = new TestViewModel
                {
                    DtoBIds = new HashSet<int>()
                };

    return View(vm);
}

[HttpPost]
[ActionName("Index")]
public IActionResult PostIndex(TestViewModel vm)
{
    SetViewBagDtoAs();

    return View("Index", vm);
}

private void SetViewBagDtoAs()
{
    ViewBag.DtoAs = new[]
                    {
                        new DtoA
                        {
                            Id   = 1,
                            Name = "A1",
                            DtoBs = new[]
                                    {
                                        new DtoB { Id = 11, Name = "B11" },
                                        new DtoB { Id = 12, Name = "B12" },
                                        new DtoB { Id = 13, Name = "B13" },
                                    }
                        },
                        new DtoA
                        {
                            Id   = 2,
                            Name = "A2",
                            DtoBs = new[]
                                    {
                                        new DtoB { Id = 14, Name = "B14" },
                                        new DtoB { Id = 15, Name = "B15" },
                                        new DtoB { Id = 16, Name = "B16" },
                                    }
                        },
                    };
}
```

ViewModel

```csharp
public class TestViewModel
{
    public HashSet<int> DtoBIds { get; set; }
}
```

View

```csharp
<form asp-action="Index" method="post">

    @{
        var dtoAs = ViewBag.DtoAs as DtoA[];
    }
    <p>
        @foreach (var dtoA in dtoAs)
        {
            <p>@(dtoA.Name)</p>
            @foreach (var dtoB in dtoA.DtoBs)
            {
                <p>
                    <input type="checkbox"
                           value="@(dtoB.Id)"
                           id="@($"{dtoA.Id}_{dtoB.Id}")"
                           name="DtoBIds"
                           @( Model.DtoBIds.Contains(dtoB.Id) ? "checked" : "" )
                           />
                    <label for="@($"{dtoA.Id}_{dtoB.Id}")">@(dtoB.Name)</label>
                </p>
            }
        }
    </p>

    <p>
        <input type="submit"
               value="Submit" />
    </p>
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