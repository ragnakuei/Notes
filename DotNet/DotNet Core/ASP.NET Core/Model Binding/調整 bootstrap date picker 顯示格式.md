# 調整 bootstrap date picker 顯示格式

- [調整 bootstrap date picker 顯示格式](#%e8%aa%bf%e6%95%b4-bootstrap-date-picker-%e9%a1%af%e7%a4%ba%e6%a0%bc%e5%bc%8f)
  - [方式一](#%e6%96%b9%e5%bc%8f%e4%b8%80)
  - [方式二](#%e6%96%b9%e5%bc%8f%e4%ba%8c)

---

## 方式一

```csharp
public class Order
{
    public int Id { get; set; }

    [DataType(DataType.Date)]
    [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:yyyy/MM/dd}")]
    public DateTime OrderDate { get; set; }
    public OrderDetail[] OrderDetails { get; set; }
}
```

---

## 方式二

asp-format 的格式還需要再調整符合 bootstrap 可以接受的格式

```xml
<div class="form-group">
    <label asp-for="Order.OrderDate"></label>
    <input asp-for="Order.OrderDate" class="form-control" asp-format="{0:yyyy/MM/dd}" type="date"/>
</div>
```
