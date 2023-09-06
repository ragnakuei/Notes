# \_\_doPostBack 取參數的方式

\<asp:LinkButton> 是為了讓 asp.net webform 自動產生對應的 script

\<a> 則是手動 hard code 呼叫 postback 的 js function

- 第一個參數是 \_\_EVENTTARGET
- 第二個參數是 \_\_EVENTARGUMENT

```html
<form id="form1" runat="server">
  <div>
    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"
      >LinkButton</asp:LinkButton
    >
    <a href="javascript:__doPostBack('TestEventTarget','TestEventArgument')"
      >Click</a
    >
  </div>
</form>
```

這樣就可以直接從 request 來取出 _EVENTTARGET 及 _EVENTARGUMENT 了

```csharp
protected void Page_Load(object sender, EventArgs e)
{
    string eventTarget = this.Request["__EVENTTARGET"];
    // var eventTarget = Request.Params["__EVENTTARGET"];
    // var eventTarget = Request.Form["__EVENTTARGET"];

    string eventArgument = this.Request["__EVENTARGUMENT"];


}

protected void LinkButton1_Click(object sender, EventArgs e)
{

}
```
