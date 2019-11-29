# [WebForms](https://docs.microsoft.com/zh-tw/aspnet/web-forms/)

- [控制項 Namespace](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.webcontrols?view=netframework-4.8)

## 基本觀念

1. URL 路徑直接針對實體檔案
1. .aspx 檔
   - [PageSection](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.configuration.pagessection?view=netframework-4.8) Tag
     1. Title
     1. Language
     1. MasterPageFile - Master Page 檔路徑，非必要，可用 `~/` 開頭代表網站根目錄
     1. [AutoEventWireup](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.configuration.pagessection.autoeventwireup)
     1. Code Behind 檔
1. 專案內的 bin 資料夾必須加入版控 (與 MVC 不同)

## 語法

- `<%= %>` - [Code Render Blocks](<https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-4.0/k6xeyd4z(v=vs.100)>) 在 render time 執行裡面的 C# expression
- `<%@ %>` - [Directives for ASP.NET Web Pages](<https://docs.microsoft.com/en-us/previous-versions/aspnet/t8syafc7(v=vs.100)>)

- `<% %>` - [Code Render Blocks](<https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-4.0/k6xeyd4z(v=vs.100)>) 用來執行多行 C# statement

* `<%: %>` - 跟 `<%= %>` 一樣，但是多了 HtmlEncodes() 的功能

* `<%# %>` - [Data-Binding Expression Syntax](https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-4.0/bda9bbfx(v=vs.100)?redirectedfrom=MSDN) - 在 data binding handler 才會執行裡面的 C# expression。應該是用於控制項中。

* `<%#: %>` - `<%: %>` 及 `<%# %>` 的結合版

* `<%$ %>` - [ASP.NET Expression](http://msdn.microsoft.com/en-us/library/d5bd1tad.aspx)

* `<%-- --%>` - server side 的註解

* `<!-- #Include -->` - [Server-Side Include Directive Syntax](<https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-4.0/3207d0e3(v=vs.100)>)

## [Code Declaration Blocks](<https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-4.0/2cy7sxha(v=vs.100)>)

## [Server-Side Object Tag Syntax](<https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-4.0/h8k45y06(v=vs.100)>)

## Master Page

1. Master Page 副檔名為 .Master
1. Master Page 同檔名的 .cs 為其 code behide 邏輯
1. Code Behide 執行順序 ： 頁面 > Master

## 值的綁定

- Eval("OrderID") - 可做字串串接
- Bind("OrderID") - 不可做字串串接

二者的差別，可參考[這裡](https://www.aspsnippets.com/Articles/Difference-between-Eval-and-Bind-functions-in-ASPNet.aspx)
