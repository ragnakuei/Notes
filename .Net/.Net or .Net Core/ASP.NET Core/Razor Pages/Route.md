# [Route](https://www.learnrazorpages.com/razor-pages/routing)

- [Route](#route)
  - [基本](#基本)
  - [給定規則](#給定規則)
  - [取值](#取值)
  - [搭配 Tag Helper](#搭配-tag-helper)

---

## 基本

預設的 Route 會以 cshtml 所在的路徑來決定

例：頁面 /Order/List.cshtml

就可以用 /Order/List 來瀏覽

---

## 給定規則

- 透過 @page 給定規則

  在 Page 頁面上 @Page 後方加上 參數化 的定義

  例：頁面 /Order/Detail.cshtml

  ```csharp
  @page "{Id}"
  ```

- 透過 AddRazorPagesOptions 給定規則

  在 Startup.cs > ConfigureServices() AddRazorPages 加上 AddRazorPagesOptions() 設定

  AddRazorPagesOptions

  ```csharp
  public void ConfigureServices(IServiceCollection services)
  {
      services.AddRazorPages()
              .AddRazorPagesOptions(options =>
                                      {
                                          options.Conventions.AddPageRoute("/Order/Detail", "/Order/Detail/{Id}");
                                      });
  }
  ```

---

## 取值

- 透過 BindProperty 取值

  ```csharp
  public class Detail : PageModel
  {
      [BindProperty(SupportsGet = true)]
      public string Id { get; set; }
      public void OnGet()
      {
      }
  }
  ```

- 透過 RouteData.Values[""] 取值

  > 不可以在 Constructor 就取值

  ```csharp
  public class Detail : PageModel
  {
      public string Id { get; set; }

      public Detail()
      {
          // 會產生 Exception
          // Id = RouteData.Values["Id"]?.ToString();
      }

      public void OnGet()
      {
          Id = RouteData.Values["Id"]?.ToString();
      }
  }
  ```

  就可以用 /order/detail/10248 來瀏覽，此時 Id 為 10248


## 搭配 Tag Helper

- 假設 Conventions Route 未定議 seqno，就會變成以 Query String 給定 ! 

```html
<div class="margin10TB padding5RL textright">
  <a asp-page="/test/test_main" asp-route-seqno="@Model.Dto.seqno" class="genbtn">上一頁</a>
  <a asp-page="/test/test_body" asp-route-seqno="@Model.Dto.seqno" class="genbtn">下一頁</a>
</div>
```