# Microsoft.AspNetCore.Mvc.Testing

可以用來對 ASP.NET Core 應用程式進行整合測試

目前找不到跟 NUnit 整合的範例

關鍵字：WebApplicationFactory

參考資料
- [Integration tests in ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/test/integration-tests?view=aspnetcore-7.0)
- [Test ASP.NET Core MVC apps](https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/test-asp-net-core-mvc-apps)



### 會出現找不到 Microsoft.Playwright.dept.json 的錯誤

當取得 client 時，會出現找不到 Microsoft.Playwright.dept.json 的錯誤

```cs
var factory = new WebApplicationFactory<Program>();
HttpClient client = factory.CreateClient();
```

解決方式：

在 Program.cs 的最後一行加上下面的程式碼，就可以了 !

```cs
public partial class Program { }
```

補充： 雖然建立了 HttpClient 但並未提供 Render Html 的功能，所以 Playwright 無法對 Html 進行測試 !
