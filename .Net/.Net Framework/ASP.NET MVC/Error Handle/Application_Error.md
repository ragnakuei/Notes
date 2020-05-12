# Application_Error

### 重新給定 HttpStatus Code

目的是為了讓 [httpErrors](https://www.notion.so/httpErrors-3a917eff09c34333ace097b4dadde100) 可以依照 HttpStatus Code 來顯示對應的頁面

Response.Status 為固定格式 !
給錯會產生 Exception

```csharp
void Application_Error(object sender, EventArgs e)
{
    // var errorException = Server.GetLastError();
    var errorException = (sender as System.Web.HttpApplication).Context.Error;
    Logger.LogException(errorException);
    
    Server.ClearError();
    Response.Clear();

    var httpStatus = HttpStatusCode.InternalServerError;
    Response.Status = $"{(int)httpStatus} {httpStatus.ToString()}";
    Response..StatusCode = (int)httpStatus;
}
```

### 使用情境1

在進入 Controller / Action 之前，如果發生錯誤，因為尚未建立 Exception Filter，所以就必須透過 Application_Error 來處理

### 語法

global.asax.cs

```csharp
void Application_Error(object sender, EventArgs e) 
{ 
    // 發生未處理錯誤時執行的程式碼

    // 抓出 Exception 內容
    var exception = (sender as System.Web.HttpApplication).Context.Error;

    // Redirect 至指定頁面
    Response.Redirect("~/Error/Index2");
}
```