# Model Binding

- [Model Binding](#model-binding)
  - [三個方式](#三個方式)
    - [透過引數](#透過引數)
    - [透過 Attribute BindProperty](#透過-attribute-bindproperty)
    - [透過 Request.Form](#透過-requestform)
    - [Validation](#validation)
  - [範例](#範例)
    - [簡單型別](#簡單型別)
    - [複雜型別 - 範例一](#複雜型別---範例一)
    - [複雜型別 - 範例二](#複雜型別---範例二)
  - [疑難雜症](#疑難雜症)

---

對應的 Property setter 的存取權限，如果不是 public 就無法做 Binding

---

## 三個方式

### 透過引數

```csharp
[ValidateAntiForgeryToken]
public class IndexModel : PageModel
{
    [Display(Name = "名稱", Prompt = "名稱")]
    [Required(ErrorMessage = "請填寫{0}")]
    [StringLength(maximumLength: 5, MinimumLength = 2, ErrorMessage = "{0} 長度要介於 {2} 及 {1} 之間")]
    public string Name { get; set; }

    [Display(Name = "單價", Prompt = "單價")]
    [Required(ErrorMessage = "請填寫{0}")]
    [Range(minimum: 1, maximum: 10, ErrorMessage = "{0} 要介於 {2} 及 {1} 之間")]
    [RegularExpression("([0-9]+)", ErrorMessage = "請輸入正整數")]
    public int? UnitPrice { get; set; }

    [Display(Name = "分配日期", Prompt = "分配日期")]
    [Required(ErrorMessage = "請填寫{0}")]
    [DataType(DataType.Date)]
    public DateTime? AssignDate { get; set; }

    public void OnGet()
    {

    }

    public void OnPost(string name, int? unitPrice, DateTime? assignDate)
    {

    }
}
```

### 透過 Attribute BindProperty

```csharp
[ValidateAntiForgeryToken]
public class IndexModel : PageModel
{
    [BindProperty]
    [Display(Name = "名稱", Prompt = "名稱")]
    [Required(ErrorMessage = "請填寫{0}")]
    [StringLength(maximumLength: 5, MinimumLength = 2, ErrorMessage = "{0} 長度要介於 {2} 及 {1} 之間")]
    public string Name { get; set; }

    [BindProperty]
    [Display(Name = "單價", Prompt = "單價")]
    [Required(ErrorMessage = "請填寫{0}")]
    [Range(minimum: 1, maximum: 10, ErrorMessage = "{0} 要介於 {2} 及 {1} 之間")]
    [RegularExpression("([0-9]+)", ErrorMessage = "請輸入正整數")]
    public int? UnitPrice { get; set; }

    [BindProperty]
    [Display(Name = "分配日期", Prompt = "分配日期")]
    [Required(ErrorMessage = "請填寫{0}")]
    [DataType(DataType.Date)]
    public DateTime? AssignDate { get; set; }

    public void OnGet()
    {

    }

    public void OnPost()
    {

    }
}
```

### 透過 Request.Form

```csharp
[ValidateAntiForgeryToken]
public class IndexModel : PageModel
{
    [Display(Name                                 = "名稱", Prompt = "名稱")]
    [Required(ErrorMessage                        = "請填寫{0}")]
    [StringLength(maximumLength: 5, MinimumLength = 2, ErrorMessage = "{0} 長度要介於 {2} 及 {1} 之間")]
    public string Name { get; set; }

    [Display(Name                                = "單價", Prompt = "單價")]
    [Required(ErrorMessage                       = "請填寫{0}")]
    [Range(minimum: 1, maximum: 10, ErrorMessage = "{0} 要介於 {2} 及 {1} 之間")]
    [RegularExpression("([0-9]+)", ErrorMessage  = "請輸入正整數")]
    public int? UnitPrice { get; set; }

    [Display(Name          = "分配日期", Prompt = "分配日期")]
    [Required(ErrorMessage = "請填寫{0}")]
    [DataType(DataType.Date)]
    public DateTime? AssignDate { get; set; }

    public void OnGet()
    {
    }

    public void OnPost()
    {
        Name = Request.Form["Name"].ToString();

        if (Int32.TryParse(Request.Form["UnitPrice"], out var unitPrice))
        {
            UnitPrice = unitPrice;
        }

        if (DateTime.TryParse(Request.Form["AssignDate"], out var assignDate))
        {
            AssignDate = assignDate;
        }
    }
}
```

### Validation

```csharp
public class Validation : PageModel
{
    [BindProperty]
    [Required]
    [MinLength( 6)]
    public string Name { get; set; }

    public void OnGet( )
    {
    }

    public IActionResult OnPost()
    {
        if (ModelState.IsValid)
        {
            // return Redirect("/Sample/Post/Validation");
            return Page();
        }
        else
        {
            return Page();
        }
    }
}
```

---

## 範例

### 簡單型別

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

### 複雜型別 - 範例一

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

### 複雜型別 - 範例二

```csharp
[ValidateAntiForgeryToken]
public class IndexModel : PageModel
{
    [BindProperty]
    public TestDto TestDto { get; set; }

    public void OnGet()
    {
    }

    public void OnPost()
    {
    }
}

public class TestDto
{
    [Display(Name                                 = "名稱", Prompt = "名稱")]
    [Required(ErrorMessage                        = "請填寫{0}")]
    [StringLength(maximumLength: 5, MinimumLength = 2, ErrorMessage = "{0} 長度要介於 {2} 及 {1} 之間")]
    public string Name { get; set; }

    [Display(Name                                = "單價", Prompt = "單價")]
    [Required(ErrorMessage                       = "請填寫{0}")]
    [Range(minimum: 1, maximum: 10, ErrorMessage = "{0} 要介於 {2} 及 {1} 之間")]
    [RegularExpression("([0-9]+)", ErrorMessage  = "請輸入正整數")]
    public int? UnitPrice { get; set; }

    [Display(Name          = "分配日期", Prompt = "分配日期")]
    [Required(ErrorMessage = "請填寫{0}")]
    [DataType(DataType.Date)]
    public DateTime? AssignDate { get; set; }
}
```

```html
@page
@model JqueryValidateUnobtrusive02.Pages.Test.IndexModel
@{
}

<style>
    .field-validation-error {
        color: #e80c4d;
        font-weight: bold;
    }

    .field-validation-valid {
        display: none;
    }

    input.input-validation-error {
        border: 1px solid #e80c4d;
    }

    .validation-summary-errors {
        color: #e80c4d;
        font-weight: bold;
        font-size: 1.1em;
    }

    .validation-summary-valid {
        display: none;
    }
</style>

<form method="post">
    <p>
        <label asp-for="TestDto.Name"></label>
        <input asp-for="TestDto.Name" />
        <span asp-validation-for="TestDto.Name"
              class="text-danger">
        </span>
    </p>
    <p>
        <label asp-for="TestDto.UnitPrice"></label>
        <input asp-for="TestDto.UnitPrice" />
        <span asp-validation-for="TestDto.UnitPrice"
              class="text-danger">
        </span>
    </p>
    <p>
        <label asp-for="TestDto.AssignDate"></label>
        <input asp-for="TestDto.AssignDate" />
        <span asp-validation-for="TestDto.AssignDate"
              class="text-danger">
        </span>
    </p>
    <p>
        <input type="submit"
               value="Submit">
    </p>
</form>

<form method="post">
</form>

@section Scripts {
    <partial name="_ValidationScriptsPartial" />
}

```

---

## 疑難雜症
