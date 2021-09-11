# Query String

- [Query String](#query-string)
  - [簡單型別](#%e7%b0%a1%e5%96%ae%e5%9e%8b%e5%88%a5)
  - [複雜型別](#%e8%a4%87%e9%9b%9c%e5%9e%8b%e5%88%a5)

## 簡單型別

在 OnGet() 給定參數就可以了

```csharp
public class Sample04 : PageModel
{
    public int PageNo { get; private set; }
    public int PageSize { get; private set; }

    public void OnGet(int pageNo, int pageSize)
    {
        PageSize = pageSize;
        PageNo = pageNo;
    }
}
```

```html
<form>
    <div class="form-group">
        <label asp-for="PageNo" class="col-sm-2 col-form-label"></label>
        <div class="col-sm-10">
            <input asp-for="PageNo" class="form-control">
        </div>
    </div>
    <div class="form-group">
        <label asp-for="PageSize" class="col-sm-2 col-form-label"></label>
        <div class="col-sm-10">
            <input asp-for="PageSize" class="form-control">
        </div>
    </div>

    @{
        var Prev = new Dictionary<string, string>
                   {
                       { nameof(Model.PageSize), Model.PageSize.ToString() },
                       { nameof(Model.PageNo), (Model.PageNo - 1).ToString() }
                   };
        var Next = new Dictionary<string, string>
                   {
                       { nameof(Model.PageSize), Model.PageSize.ToString() },
                       { nameof(Model.PageNo), (Model.PageNo + 1).ToString() }
                   };
    }
    <div class="form-group row">
        <a asp-all-route-data="Prev" >@nameof(Prev)</a>
        <a asp-all-route-data="Next" >@nameof(Next)</a>
    </div>

    <div class="form-group">
        <input type="submit" value="Submit" class="btn btn-primary"/>
    </div>
</form>
```

## 複雜型別
