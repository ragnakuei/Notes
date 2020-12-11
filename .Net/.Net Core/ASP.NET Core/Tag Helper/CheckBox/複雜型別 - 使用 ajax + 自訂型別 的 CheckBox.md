# 複雜型別 - 使用 ajax + 自訂型別 的 CheckBox

這個範例只適合做在 ajax 的情況

註：
> 用於 form post 的範例，目前還沒想到
> 因為要在 ModelState.IsValid == false 時，仍保有原本的選擇與 Id

如果 View 的 TestViewModel.TestItemDtos 在 Post 的 FormData
- 只有一個項目，必須要用 T[] 型態來 binding
- 有二個以上項目，就可以使用原本的型態來 binding，但未勾選的項目，就不會有 html value 欄位 (TestItemDto.ForeignKeyId)

可以取出 ForeignKeyId 不為 null 的項目，就是勾選的資料

而勾選項目中
- Id 有值，代表是上次已勾選，此次仍勾選
- Id 沒有值，代表是此次才勾選的



## 範例

在 View 只勾選第一、二個項目後，Debug Mode 進入 PostIndex 來看結果

[Github 連結](https://github.com/ragnakuei/CheckBoxPractice2)

### ViewModel 結構

```csharp
public class TestViewModel
{
    public TestItemDto[] TestItemDtos { get; set; }
}

public class TestItemDto
{
    /// <summary>
    /// 資料表 Priamry Key
    /// </summary>
    public int? Id { get; set; }

    /// <summary>
    /// 清單項目的 Id
    /// </summary>
    public int? ForeignKeyId { get; set; }

    public string Name { get; set; }
}
```

### Controller

```csharp
[HttpGet]
public IActionResult Index()
{
    // 這個範例只適合做在 ajax 的情況
    // 用於 form post 的範例，目前還沒想到

    var vm = new TestViewModel
             {
                 TestItemDtos = GetTestItemDtos()
             };

    // 把其中二個項目指定為無 Id ，代表原本的資料無勾選
    vm.TestItemDtos[1].Id = null;
    vm.TestItemDtos[3].Id = null;

    return View(vm);
}

[HttpPost]
public IActionResult PostIndex(TestViewModel vm)
{
    // 如果 View 的 TestItemDto.TestItemDtos 在 Post 的 FormData
    // - 只有一個項目，必須要用 T[] 型態來 binding
    // - 有二個以上項目，就可以使用原本的型態來 binding，但未勾選的項目，就不會有 html value 欄位 (TestItemDto.ForeignKeyId)


    // 可以取出 ForeignKeyId 不為 null 的項目，就是勾選的資料
    // 勾選項目中
    // - Id 有值，代表是上次已勾選，此次仍勾選
    // - Id 沒有值，代表是此次才勾選的
    var checkItems = vm.TestItemDtos
                       .Where(dto => dto.ForeignKeyId != null)
                       .ToArray();

    return RedirectToAction("Index");
}

private static TestItemDto[] GetTestItemDtos()
{
    return new[]
           {
               new TestItemDto { Id = 1, Name = "A", ForeignKeyId = 11 },
               new TestItemDto { Id = 2, Name = "B", ForeignKeyId = 12 },
               new TestItemDto { Id = 3, Name = "C", ForeignKeyId = 13 },
               new TestItemDto { Id = 4, Name = "D", ForeignKeyId = 14 },
               new TestItemDto { Id = 5, Name = "E", ForeignKeyId = 15 },
           };
}
```

### View

```html
@model CheckBoxPractice.Controllers.TestViewModel
@{
    ViewData["Title"] = "Home Page";
}

<form method="post"
      asp-action="PostIndex">

    @for (var index = 0; index < Model.TestItemDtos.Length; index++)
    {
        // Id 有值，代表有勾選
        var isChecked = Model.TestItemDtos[index].Id == null
                            ? string.Empty
                            : "checked";

        <p>
            <input type="hidden" asp-for="@(Model.TestItemDtos[index].Id)" />

            <input type="checkbox"
                   id="TestItemDtos[@(index)].ForeignKeyId"
                   name="TestItemDtos[@(index)].ForeignKeyId"
                   value="@(Model.TestItemDtos[index].ForeignKeyId)"
                   @(isChecked) />
            <label for="TestItemDtos[@(index)].ForeignKeyId">
                @(Model.TestItemDtos[index].Name)
            </label>

            <input type="hidden" asp-for="@(Model.TestItemDtos[index].Name)" />
        </p>
    }

    <input type="submit"
           value="Sumbit" />
</form>
```