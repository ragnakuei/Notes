# 在同一個頁面動態多次加入相同的 UserControl

## 問題

> 在同一個頁面動態多次加入相同的 UserControl，會發生只會加入最後一次加入的 User Control

```csharp
protected override void OnPreLoad(EventArgs e)
{
    base.OnPreLoad(e);

    var pagination = (BootstrapPagination)Page.LoadControl("~/UserControls/BootstrapPagination.ascx");
    pagination.PageIndex = _pageIndex;
    pagination.TotalCount = _totalCount;
    pagination.PageSize = _pageSize;
    pagination.Positon = "right";
    upperPagination.Controls.Add(pagination);
    bottomPagination.Controls.Add(pagination);
}
```

## 解決方式

> 複製 UserControl instance 後，就可以了 !

```csharp
public partial class BootstrapPagination : System.Web.UI.UserControl
{
    public BootstrapPagination DeepClone()
    {
        return this.MemberwiseClone() as BootstrapPagination;
    }
}
```

原本呼叫點的語法要改成

```csharp
protected override void OnPreLoad(EventArgs e)
{
    base.OnPreLoad(e);

    var pagination = (BootstrapPagination)Page.LoadControl("~/UserControls/BootstrapPagination.ascx");
    pagination.PageIndex = _pageIndex;
    pagination.TotalCount = _totalCount;
    pagination.PageSize = _pageSize;
    pagination.Positon = "right";
    upperPagination.Controls.Add(pagination);
    bottomPagination.Controls.Add(pagination.DeepClone());   // 這裡要加上 DeepClone()
}
```
