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


## 略過 Custom Error 的處理

```cs
void Application_Error(object sender, EventArgs e)
{
    // 取得 Exception
    var exception = Server.GetLastError().GetBaseException();
    
    HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.BadRequest;
    HttpContext.Current.Response("123");

    // 不套用 Web.config Custom Errors
    // 就可以給定自訂的 Response.Write() 了
    HttpContext.Current.Response.TrySkipIisCustomErrors = true;

    Server.ClearError();
}  
```