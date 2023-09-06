# [ViewComponent](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/view-components)

-   與 `Partial View` 達成的效果差不多
-   分成二個部份 `C#`、`Razor`
    -   C#
        -   檔案預設讀取
            -   根目錄下的 `ViewComponents` 資料夾
            -   經測試後，在 Asp.Net Core Razor Page 框架中，可以放在 Pages/Components 資料夾中
                -   就可以讓 View Components 的 cs 與 cshtml 放在同一個資料夾中
        -   必須繼承 `ViewComponent`
        -   進入點為 `InvokeAsync()` 參數自訂
    -   Razor
        -   檔案預設放在 
            -   View/Shared/[ViewComponentName]/Default.cshtml
            -   Pages/Components/[ViewComponentName]/Default.cshtml
            -   也可以在 return View 時指定
        -   其餘使用方式與 Razor View 相同

## 範例

```csharp
// 如果要指定不同的 ViewComponentName 可透過以下的語法
//[ViewComponent(Name = "PriorityList")]
public class PriorityListViewComponent : ViewComponent
{
    public PriorityListViewComponent()
    {
    }

    public async Task<IViewComponentResult> InvokeAsync(int maxPriority, bool isDone)
    {
        return View(new Dto { MaxPriority = maxPriority, IsDone = isDone });

        // 也可以指定 VIew 的路徑
        // return View("~/Pages/Components/Users/Default.cshtml",message);
    }
}
```

Default.cshtml

```csharp
@model WebApplication7.Controllers.Dto
@{ }

<p>@(Model.MaxPriority)</p>
<p>@(Model.IsDone)</p>
```

### 在 View 內呼叫 ViewComponent 的方式

-   方式一

    ```csharp
    @await Component.InvokeAsync("PriorityList", new { maxPriority = 4, isDone = true })
    ```

-   方式二

    要在 _ViewImports 加上下面的語法：
    
    ```cs
    @addTagHelper *, MyProject01
    ```

    就可以在 View 內直接以 kebab-case 的方式來呼叫 View Component !

    ```csharp
    <vc:priority-list max-priority="2" is-done="false">
    </vc:priority-list>
    ```

### 在 Action 內呼叫 ViewComponent 的方式

```csharp
public IActionResult IndexVC()
{
    return ViewComponent("PriorityList", new { maxPriority = 3, isDone = false });
}
```
