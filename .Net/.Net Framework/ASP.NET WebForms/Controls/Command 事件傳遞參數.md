# Command 事件傳遞參數

可以透過 Controls 上面的 Command Event 來傳遞 Command Agruments

```html
<asp:LinkButton
    ID="LinkButton1"
    runat="server"
    CommandName="TestName"
    CommandArgument="TestAgrument"
    OnCommand="LinkButton1_Click">
    LinkButton
</asp:LinkButton>
```

在 CommandEventArgs 中，就可以取出 ComandName 及 CommandArgument 資料

```csharp
protected void LinkButton1_Click(object sender, CommandEventArgs e)
{

}
```
