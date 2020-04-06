# [ClientScript](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.page.clientscript)

---

[RegisterStartupScript(Type, String, String)](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.clientscriptmanager.registerstartupscript)

```csharp
Page.ClientScript.RegisterStartupScript(
    this.GetType(),
    "",
    "<script text=\'text/JavaScript\'>alert('完成,單號：" + ecpFormId + "');location.href='Index.aspx';</script>");
```
