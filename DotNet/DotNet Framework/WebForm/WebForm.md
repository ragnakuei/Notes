# [WebForm](https://docs.microsoft.com/zh-tw/aspnet/web-forms/)

- [控制項 Namespace](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.webcontrols?view=netframework-4.8)

## 基本觀念

1. URL 路徑直接針對實體檔案
1. .aspx 檔
   - [PageSection](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.configuration.pagessection?view=netframework-4.8) Tag
     1. Title
     1. Language
     1. MasterPageFile - Master Page 檔路徑，非必要，可用 `~/` 開頭代表網站根目錄
     1. [AutoEventWireup](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.configuration.pagessection.autoeventwireup?view=netframework-4.8)
     1. Code Behind 檔
1. 專案內的 bin 資料夾必須加入版控 (與 MVC 不同)

## Master Page

1. Master Page 副檔名為 .Master
1. Master Page 同檔名的 .cs 為其 code behide 邏輯
1. Code Behide 執行順序 ： 頁面 > Master

## 值的綁定

- Eval("OrderID") - 可做字串串接
- Bind("OrderID") - 不可做字串串接

二者的差別，可參考[這裡](https://www.aspsnippets.com/Articles/Difference-between-Eval-and-Bind-functions-in-ASPNet.aspx)
