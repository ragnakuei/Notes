# 自訂 HtmlHelper

學習資料：http://www.asp.net/mvc/overview/older-versions-1/views/creating-custom-html-helpers-cs

運用工具：
- [StringBuilder](https://msdn.microsoft.com/zh-tw/library/system.text.stringbuilder%28v=vs.110%29.aspx)
- [TagBuilder](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.mvc.tagbuilder)
	
	用StringBuilder去加TagBuilder，最後以StringBuilder做輸出

產生步驟：

1. 建立 ~/Helpers 資料夾
2. 先在 view.cshtml 內產生顯示的邏輯，確定顯示邏輯沒問題
3. 建立 ~/Helpers/CustomHtmlHelper.cs (類別)，檔名可自取，或依照專案既有的。
4. 新增 extension method，擴充引數 this HtmlHelper helper，把 2 的結果複製至這個 method 中，method 回傳值為 MvcHtmlString

修改&測試