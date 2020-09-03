# [ViewComponent](https://docs.microsoft.com/en-us/aspnet/core/mvc/views/view-components)

-   與 `Partial View` 達成的效果差不多
-   分成二個部份 `C#`、`Razor`
    -   C#
        -   必須繼承 `ViewComponent`
        -   進入點為 `InvokeAsync()` 參數自訂
    -   Razor
        -   檔案必須放在 View/Shared/[ViewComponentName]/Default.cshtml
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
