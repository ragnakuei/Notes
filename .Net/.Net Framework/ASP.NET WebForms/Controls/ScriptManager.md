# ScriptManager

[https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.scriptmanager](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.scriptmanager)

[ASP.NET 4.5 ScriptManager Improvements in WebForms](https://devblogs.microsoft.com/aspnet/asp-net-4-5-scriptmanager-improvements-in-webforms/)

## RegisterClientScriptBlock()

在 <form></form> 裡面第一行加上 指定的 js script

```csharp
ScriptManager.RegisterClientScriptBlock(this
                                        , this.GetType()
                                        , "alertWin"
                                        , "<script>alert('Test');</script>"
                                        , false);
```

```csharp
ScriptManager.RegisterClientScriptBlock(this
                                        , this.GetType()
                                        , "alertWin"
                                        , "alert('Test2');"
                                        , true);
```

以上二個結果相同，但是下面語法會產生下面的外框

```html
//<![CDATA[

//]]>
```