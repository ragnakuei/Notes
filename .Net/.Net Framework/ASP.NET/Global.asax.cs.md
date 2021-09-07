# Global.asax.cs

## Route 找不到，統一導到錯誤頁面

```csharp
void Application_Error(object sender, EventArgs e)
{
    // 發生未處理錯誤時執行的程式碼
    var error = Server.GetLastError();
    Console.WriteLine($"Application Error:{error.Message}");

    Response.Redirect("/Error/NotFound");
}
```
