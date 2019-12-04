# Page

[Page Lifecycle](https://docs.microsoft.com/en-us/previous-versions/ms178472(v=vs.140)?redirectedfrom=MSDN)

---

## [AutoEventWireup](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.configuration.pagessection.autoeventwireup)

- [最好停用 AutoEventWireup](https://stackoverflow.com/questions/1494543/what-calls-page-load-and-how-does-it-do-it)

    > Now it is better to disable AutoEventWireup and either create these event handlers yourself in the pages OnInit method or simply override the parent page's OnLoad method.

