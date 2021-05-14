# UIHint

## 原理

-   預搭配以下方式
    -   資料夾
        -   DisplayTemplates
        -   EditorTemplates
    -   Html Helper
        -   DisplayFor
        -   EditorFor

### 先宣告 UIHint

-   在 ViewModel 的指定 Property 加上
    ```csharp
    [UIHint("CustomUihint")]
    ```
    -   告訴 Razor Engine 
        -   在 Render DisplayFor 時，要找 Views/Shared/DisplayTemplates/CustomUihint.cshtml
        -   在 Render EditorFor 時，要找 Views/Shared/EditorTemplates/CustomUihint.cshtml
    -   CustomUihint 名稱為自訂
        -   不同的情境下，可以有不同的 Template 來顯示 !

### Display 部份

-   在 Views/Shared/ 建立 DisplayTemplates
-   建立 CustomUihint.cshtml
    ```html
    @model DateTime?

    @Model?.ToString("yyyy/MM/dd")
    ```    

### Editor 部份

-   在 Views/Shared/ 建立 EditorTemplates
-   建立 CustomUihint.cshtml
    ```html
    @model DateTime?
    <input type="Date" asp-for="@Model">
    ```    
