# 簡單型別 - 以父類群組化 Checkbox

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