# Model Binding

- [Model Binding](#model-binding)
  - [簡單型別](#%e7%b0%a1%e5%96%ae%e5%9e%8b%e5%88%a5)
  - [複雜型別](#%e8%a4%87%e9%9b%9c%e5%9e%8b%e5%88%a5)
  - [疑難雜症](#%e7%96%91%e9%9b%a3%e9%9b%9c%e7%97%87)

---

對應的 Property setter 的存取權限，如果不是 public 就無法做 Binding

---

## 簡單型別

- 針對需要在 Binding 至 PageModel 的欄位上加上 `BindProperty`

  - Test1 可以在 Post 時，保有 Post 時的資料，再加上 Z 字元，再回傳至 View 中
  - Test2 在每次 Post 時，都會清空資料

```html
@page @model RazorPages.Pages.Order.Index @Model.Message

<form method="post">
  <input asp-for="Test1" />
  <input asp-for="Test2" />
  <input type="submit" value="Create" class="btn btn-primary" />
</form>
```

```csharp
public class Index : PageModel
{
    [BindProperty]
    public string Test1 { get; set; }
    public string Test2 { get; set; }

    public async Task<IActionResult> OnPostAsync()
    {
        Test1 += "Z";
        ModelState.Remove(nameof(Test1));
        ModelState.Remove(nameof(Test2));

        return Page();
    }
}
```

---

## 複雜型別

- 針對需要在 Binding 至 PageModel 的欄位上加上 `BindProperty`
- 使用 Tag Helper 來 Binding Property 更好維護

  ```html
  @page @model RazorPages.Pages.Sample.Sample05

  <h1>Sample05</h1>

  <form method="post">
    <div class="form-group">
      <label asp-for="Order.Id"></label>
      <input asp-for="Order.Id" class="form-control" />
    </div>
    <div class="form-group">
      <label asp-for="Order.OrderDate"></label>
      <input asp-for="Order.OrderDate" class="form-control" type="date" />
    </div>

    <label>Order Detail</label>
    <table class="table table-striped">
      <thead>
        <tr>
          <th>@(nameof(OrderDetail.ProductId))</th>
          <th>@(nameof(OrderDetail.Count))</th>
        </tr>
      </thead>
      <tbody>
        @for (var index = 0 ; index < Model.Order?.OrderDetails?.Length ;
        index++) {
        <tr>
          <td>
            <label asp-for="Order.OrderDetails[index].ProductId"></label>
            <input
              asp-for="Order.OrderDetails[index].ProductId"
              class="form-control"
            />
          </td>
          <td>
            <label asp-for="Order.OrderDetails[index].Count"></label>
            <input
              asp-for="Order.OrderDetails[index].Count"
              class="form-control"
            />
          </td>
        </tr>
        }
      </tbody>
    </table>

    <input type="submit" value="Submit" class="btn btn-primary" />
  </form>
  ```

  ```csharp
  public class Sample05 : PageModel
  {
      [BindProperty]
      public Order Order { get; set; }

      public IActionResult OnGet()
      {
          Order = new Order
                  {
                      OrderDetails = new OrderDetail[2]
                  };
          return Page();
      }

      public IActionResult OnPost()
      {
          ModelState.Remove(nameof(Order));
          return Page();
      }
  }

  public class Order
  {
      public int? Id { get; set; }

      public DateTime? OrderDate { get; set; }
      public OrderDetail[] OrderDetails { get; set; }
  }

  public class OrderDetail
  {
      public int? ProductId { get; set; }
      public int? Count { get; set; }
  }
  ```

---

## 疑難雜症
