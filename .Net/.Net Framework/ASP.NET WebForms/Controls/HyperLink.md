# [HyperLink](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.webcontrols.hyperlinks)

會轉成 \<a>\</a>

連結會導至 Detail/OrderId 的頁面

```html
<asp:HyperLink 
    ID="HyperLink1" 
    runat="server" 
    HeaderText="View" 
    NavigateUrl='<%# "Detail/" + Eval("OrderId") %>' 
    Text="Edit" />
```