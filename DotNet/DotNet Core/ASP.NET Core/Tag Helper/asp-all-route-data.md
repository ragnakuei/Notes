# [asp-all-route-data.md](https://www.learnrazorpages.com/razor-pages/tag-helpers/anchor-tag-helper#notes)

可以透過 asp-all-route-data 取用 Dictionary<string, string> 來直接組成 route 及 query string


```xml
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
```

```html
<a href="/Sample/Sample04?PageSize=10&PageNo=7">Prev</a>
<a href="/Sample/Sample04?PageSize=10&PageNo=9">Next</a>
```