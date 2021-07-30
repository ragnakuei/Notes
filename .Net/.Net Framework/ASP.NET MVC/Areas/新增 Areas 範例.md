# 新增 Areas 範例

## 自動

步驟：
1. 在專案上按下滑鼠右鍵
2. 選擇 新增 Scaffold 項目
3. 選擇 通用 > MVC > 區域
4. 輸入 Area 名稱
5. 完成建立

## 手動

步驟：

1. 在 MVC 專案內新增 Areas 資料夾
1. 在 Areas 資料夾內，新增指定的 Area Name 資料，假設是 Blogs
1. 在上述資料夾內建立 Controllers、Views 資料夾
    1. 把外層 Views 資料夾的以下檔案複製到在上述的 Views 資料夾中
        1. Web.config
        1. Shared > \_ViewStart.cshtml
        1. 其他視情況自行複製
1. 新增 Area 對應的 Route
    
    先確認 Global.asax.cs 有呼叫這段語法
    ```csharp
    AreaRegistration.RegisterAllAreas();
    ```

    新增類別

     - 建議把 namespaces 也加上去，避免相同 Controller 名稱會衝突

    ```csharp
    public class BlogsAreaRegistration : AreaRegistration
    {
        public override string AreaName => "Blogs";

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                name: "Blogs",
                url: "Blogs/{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                namespaces: new [] { "TestAreas.Areas.Blogs.Controllers" }
            );
        }
    }
    ```

    原本的 Route 指定 namespaces，以避免同名 Controller 衝突

    ```csharp
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional },
                namespaces: new[] { "TestAreas.Controllers" }
            );
        }
    }
    ```

1. 基本設定完成