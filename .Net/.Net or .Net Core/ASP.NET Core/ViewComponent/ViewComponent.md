# [ViewComponent](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/view-components)

ViewComponent 同樣分為 .cs 與 .cshtml
    - 用來取代 Asp.Net MVC Action / RenderAction 的角色
    - .cs 就是 Controller 的部份
    - .cshtml 就是 View 的部份

### ViewComponent Class

1. 存放資料夾
   - 可以隨意放
1. 宣告方式有三個
   1. Deriving from **ViewComponent**
   1. Decorating a class with the **[ViewComponent]** attribute, or deriving from a class with the **[ViewComponent]** attribute
   1. Creating a class where the name ends with the suffix **ViewComponent**
1. 支援 Dependency Injection
1. 不可使用 Filter
1. 呼叫 Method

   同步：
   ```cs
   public IViewComponentResult Invoke(string str)
   {
       return View("Index",model: str);
   }
   ```

   非同步：
   ```cs
   public async Task<IViewComponentResult> InvokeAsync(string str)
   {
       return View("Index",model: await Task.FromResult(str));
   }
   ```

### ViewComponent View

1. 搜尋檔案順序
   1. /Views/{Controller Name}/Components/{View Component Name}/{View Name}
   1. /Views/Shared/Components/{View Component Name}/{View Name}
   1. /Pages/Shared/Components/{View Component Name}/{View Name}
1. 預設搜尋檔名為 Default.cshtml
   - 可以自訂
1. View 端的呼叫方式
   1. 透過 **@await Component.InvokeAsync()** 來呼叫

        - 傳入參數
          1. ViewComponent 名稱
          2. 呼叫 ViewComponent.Invoke() / InvokeAsync() 的 參數

        ```cs
        @await Component.InvokeAsync("Test", new { str = "A" })
        ```

   1. 以 html tag 方式呼叫

        - 名稱必須要以 **Kebab Case** 方式給定
          - 例如：Component Name 為 PriorityList 時，就要以 **vc:priority-list** 來呼叫
        - 傳入參數
          - 以 html attribute 方式給定
        - 在 **_ViewImports.cshtml** 必須加上新的一行
          
          WebApplicationAssembly 為 ViewComponent 所在的 Assembly !

          ```cs
          @addTagHelper *, WebApplicationAssembly
          ```

         ```html
         <vc:test str="B" />
         <vc:test str="B"></vc:test>
         ```

   1. 在 Controller 內呼叫

        ```cs
        public IActionResult IndexVC()
        {
            return ViewComponent("PriorityList", new { maxPriority = 3, isDone = false });
        }
        ```