# [Select Tag Helper](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/working-with-forms#the-select-tag-helper)

1. Sample

    ```csharp
    [HttpGet]
    public IActionResult SetCulture()
    {
        ViewData["SupportedUICultures"] = _options.Value
                                            .SupportedUICultures
                                            .Select(c => new SelectListItem
                                            {
                                                Value = c.Name,
                                                Text = c.DisplayName
                                            }).ToList();

        var model = new SetCulture();
        model.culture = CultureInfo.CurrentUICulture.Name;
        return View(model);
    }
    ```

    ```html
    <select asp-for="culture"
            asp-items="@(ViewData["SupportedUICultures"] as List<SelectListItem>)">
    </select>
    ```

1. 注意事項

    中間的 Razor 註解語法會導致 Tag Helper 失效。

    ```html
    <select class="form-control"
            @* data-val="true" *@
            data-val-required="The Employee field is required."
            asp-items=@(ViewData["Employees"] as List<SelectListItem>)
            asp-for="EmployeeId">
    </select>
    ```

1. 給定初始未選擇的做法

    直接給定就可以了，剩下的 option 才會從 items 取出並附加上去

    ```html
    <div class="form-group">
        <label_required asp-for="Gender" class="col-xs-2 col-sm-2 control-label text-right"></label_required>
        <div class="col-xs-10 col-sm-10">
            <select asp-for="Gender"
                    asp-items="Html.GetEnumSelectList<Gender>()"
                    class="form-control">
                <option value="">--Please Select--</option>
            </select>
            <span asp-validation-for="Gender"></span>
        </div>
    </div>
    ```

1. 搭配 Enum

    ```csharp
    public enum Gender : short
    {
        [Display(Name = "Male")]
        Male = 0,
        [Display(Name = "Female")]
        Female = 1,
    }
    ```

    asp-items 就是用來指向 enum 的
    asp-for 就是用來指定 ViewModel 的 Property

    ```html
    <div class="form-group">
        <label_required asp-for="Gender" class="col-xs-2 col-sm-2 control-label text-right"></label_required>
        <div class="col-xs-10 col-sm-10">
            <select asp-for="Gender"
                    asp-items="Html.GetEnumSelectList<Gender>()"
                    class="form-control">
            </select>
            <span asp-validation-for="Gender"></span>
        </div>
    </div>
    ```
