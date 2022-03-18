# LINQ 取回分頁資料_含總筆數


```cs
void Main()
{
    var pageModel = new PageModel<Orders>
    {
        PageSize = 10,
        PageNo = 2,
    };

    GetPageData(pageModel, Orders.Where(o => o.EmployeeID == 4));
    
    pageModel.Dump();
}

private void GetPageData<T>(PageModel<T> pageModel, IQueryable<T> data)
{
    var os = data
    .Select(i => new { id = 1, item = i, })
    .GroupBy(g => new { g.id })
    .Select(g => new
    {
        List = g.Skip(pageModel.Skip).Take(pageModel.PageSize),
        Count = g.Count()
    })
    .FirstOrDefault();

    pageModel.PageData = os.List.Select(o => o.item);
    pageModel.Count = os.Count;
}

public class PageModel<T>
{
    public int PageSize { get; set; }

    /// <summary>
    /// base 1
    /// </summary>
    public int PageNo { get; set; }

    public int Skip => (PageNo - 1) * PageSize;

    public IEnumerable<T> PageData { get; set; }

    public int Count { get; set; }
}
```