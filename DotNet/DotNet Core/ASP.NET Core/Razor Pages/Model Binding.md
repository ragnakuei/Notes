# Model Binding

- [Model Binding](#model-binding)
  - [簡單型別](#%e7%b0%a1%e5%96%ae%e5%9e%8b%e5%88%a5)
  - [複雜型別](#%e8%a4%87%e9%9b%9c%e5%9e%8b%e5%88%a5)
  - [疑難雜症](#%e7%96%91%e9%9b%a3%e9%9b%9c%e7%97%87)

---

## 簡單型別

- 針對需要在 Binding 至 PageModel 的欄位上加上 `BindProperty`
  
  - Test1 可以在 Post 時，保有 Post 時的資料，再加上 Z 字元，再回傳至 View 中
  - Test2 在每次 Post 時，都會清空資料

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

  ```html
  @page @model RazorPages.Pages.Order.Index @Model.Message
  
  <form method="post">
  <input asp-for="Test1" />
  <input asp-for="Test2" />
  <input type="submit" value="Create" class="btn btn-primary" />
  </form>
  ```

---

## 複雜型別

---

## 疑難雜症

