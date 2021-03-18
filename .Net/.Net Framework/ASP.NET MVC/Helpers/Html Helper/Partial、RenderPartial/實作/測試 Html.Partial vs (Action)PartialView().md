# 測試 Html.Partial vs (Action)PartialView()

比較以下二個內容

1. Index01內呼叫Html.Partial("_Partial01")
2. Index02內呼叫Html.Action("Index002")
Action：Index002內，再使用PartialView()

結論：測不出差異

將Action Index002回傳值改為View()，View內設定Layout=null;，其效能與設定未變更前是一樣的
但是Action Index002回傳值改為View()，再指定Layout，效能上就會慢一些些，因為要讀Layout的內容

Controller

```csharp
public ActionResult Index01()
{
    return View();
}

public ActionResult Index02()
{
    return View();
}

public ActionResult Index002()
{
    return PartialView(db.Customers.Take(10).ToList());
}

public ActionResult _Partial01()
{
    return PartialView(db.Customers.Take(10).ToList());
}
```

Index01

```csharp
@{
    ViewBag.Title = "Index01";
}

<h2>Index01</h2>
@{
    System.Text.StringBuilder sb = new System.Text.StringBuilder();
    MvcHtmlString mhs;
    var timesOut = Enumerable.Range(0, 1);
    var timesIn = Enumerable.Range(0, 100);
    var watch = new System.Diagnostics.Stopwatch();
    //以上可事先宣告

    watch.Restart();
    //進行測試
    foreach (var item1 in timesOut)
    {
        foreach (var item2 in timesIn)
        {
            //此處放測試的部份
            mhs = Html.Action("_Partial01");
        }
        //小段測試結束
        watch.Stop();
        var elapsedMs = watch.ElapsedMilliseconds;
        sb.Append("<text>Time Cost：" + elapsedMs + "</text><br />");
    }
    //測試結束
    @MvcHtmlString.Create(sb.ToString())
}
```

Index02

```csharp
@{
    ViewBag.Title = "Index02";
}

<h2>Index02</h2>
@{
    System.Text.StringBuilder sb = new System.Text.StringBuilder();
    MvcHtmlString mhs;
    var timesOut = Enumerable.Range(0, 1);
    var timesIn = Enumerable.Range(0, 100);
    var watch = new System.Diagnostics.Stopwatch();
    //以上可事先宣告

    watch.Restart();
    //進行測試
    foreach (var item1 in timesOut)
    {
        foreach (var item2 in timesIn)
        {
            //此處放測試的部份
            mhs = Html.Action("Index002");
        }
        //小段測試結束
        watch.Stop();
        var elapsedMs = watch.ElapsedMilliseconds;
        sb.Append("<text>Time Cost：" + elapsedMs + "</text><br />");
    }
    //測試結束
    @MvcHtmlString.Create(sb.ToString())
}
```

_Partial01

```csharp
@model IEnumerable<WebApplication10.Models.Customer>

@{
    ViewBag.Title = "Index01";
}

<p>
    @{ }
</p>
<table class="table">
    <tr>
        <th>
            @Html.DisplayNameFor(model => model.CompanyName)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.ContactName)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.ContactTitle)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.Address)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.City)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.Region)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.PostalCode)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.Country)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.Phone)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.Fax)
        </th>
        <th></th>
    </tr>

@foreach (var item in Model) {
    <tr>
        <td>
            @Html.DisplayFor(modelItem => item.CompanyName)
        </td>
        <td>
            @Html.DisplayFor(modelItem => item.ContactName)
        </td>
        <td>
            @Html.DisplayFor(modelItem => item.ContactTitle)
        </td>
        <td>
            @Html.DisplayFor(modelItem => item.Address)
        </td>
        <td>
            @Html.DisplayFor(modelItem => item.City)
        </td>
        <td>
            @Html.DisplayFor(modelItem => item.Region)
        </td>
        <td>
            @Html.DisplayFor(modelItem => item.PostalCode)
        </td>
        <td>
            @Html.DisplayFor(modelItem => item.Country)
        </td>
        <td>
            @Html.DisplayFor(modelItem => item.Phone)
        </td>
        <td>
            @Html.DisplayFor(modelItem => item.Fax)
        </td>
        <td>
            @Html.ActionLink("Edit", "Edit", new { id=item.CustomerID }) |
            @Html.ActionLink("Details", "Details", new { id=item.CustomerID }) |
            @Html.ActionLink("Delete", "Delete", new { id=item.CustomerID })
        </td>
    </tr>
}

</table>
```

Index002

```csharp
@model IEnumerable<WebApplication10.Models.Customer>

@{
    Layout = null;
    ViewBag.Title = "Index002";
}

<h2>Index002</h2>

<p>
    @{ }
</p>
<table class="table">
    <tr>
        <th>
            @Html.DisplayNameFor(model => model.CompanyName)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.ContactName)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.ContactTitle)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.Address)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.City)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.Region)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.PostalCode)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.Country)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.Phone)
        </th>
        <th>
            @Html.DisplayNameFor(model => model.Fax)
        </th>
        <th></th>
    </tr>

    @foreach (var item in Model)
    {
        <tr>
            <td>
                @Html.DisplayFor(modelItem => item.CompanyName)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.ContactName)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.ContactTitle)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.Address)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.City)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.Region)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.PostalCode)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.Country)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.Phone)
            </td>
            <td>
                @Html.DisplayFor(modelItem => item.Fax)
            </td>
            <td>
                @Html.ActionLink("Edit", "Edit", new { id = item.CustomerID }) |
                @Html.ActionLink("Details", "Details", new { id = item.CustomerID }) |
                @Html.ActionLink("Delete", "Delete", new { id = item.CustomerID })
            </td>
        </tr>
    }

</table>
```