# Areas

[Areas in ASP.NET Core](https://docs.microsoft.com/zh-tw/aspnet/core/mvc/controllers/areas)

## 新增 Areas 標準步驟

1. 在 專案根目錄下，建立 `Areas` 的資料夾
1. 在 `Areas` 的資料夾中，建立該 Areas 所對應的 Area 資料夾
   例： `SystemManagement`
1. 在 Area 資料夾 中，分別建立 `Controllers` 及 `Views` 二個資料夾
1. 上述的二個資料夾，就是對應 MVC 的 `Controllers` 及 `Views`
1. StartUp.Configure() 新增 MVC Route

    ```csharp
    app.UseEndpoints(endpoints =>
    {
        // 這個是對對應 Areas 的
        endpoints.MapControllerRoute(
                                    name: "defaultArea",
                                    pattern: "{area:exists}/{controller}/{action=Index}/{id?}");
        // 這個是既有的
        endpoints.MapControllerRoute(
                                    name: "default",
                                    pattern: "{controller=Home}/{action=Index}/{id?}");
    });
    ```

1. 所有 Area 中的 Controller，都要加上 `[Area("AreaName")]`
   例：`[Area("SystemManagement")]`

## 注意事項

### 資料夾結構

假設要新增的 Area 是 `SampleArea`，就要在 專案根目錄下，建立 `SampleArea` 的資料夾

1. 該 Areas 中的 Controller 就要放在

    > 專案/SampleArea/Controllers

1. 該 Areas 中的 View 就要放在

    > 專案/SampleArea/Views/[對應的 Controller]

1. 原本 MVC 的範本來說，以下二個檔案是在 `Views/` 中

    - \_ViewImports.cshtml
    - \_ViewStart.cshtml

    在使用 Areas 時，上述二個檔案尋找方式

    - Views 所在資料夾
    - Views 所在資料夾的所有上層父資料夾

    > 原本 專案/Views 的尋找方式也是一樣

    所以上述二個檔案的共用，在需要共用的情況下，就直接放到 `專案根目錄`，會是最直接的 !
