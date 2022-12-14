# HtmlControl


```cs
<asp:ListView runat="server" ID="lst_Dtos" OnItemDataBound="lst_Dtos_ItemDataBound">
    <ItemTemplate>
        <span id="lst_span" runat="server"> <%# Eval("Amount") %> </span>
    </ItemTemplate>
</asp:ListView>
```

```cs
protected void Page_Load(object sender, EventArgs e)
{
    var random = new Random();
    var dtos = Enumerable.Range(1, 10).Select(i =>
    {
        var dto = new TestDto { Amount = random.Next(1, 100) };
        return dto;
    }).ToArray();

    lst_Dtos.DataSource = dtos;
    lst_Dtos.DataBind();
}

protected void lst_Dtos_ItemDataBound(object sender, ListViewItemEventArgs e)
{
    if(e.Item.FindControl("lst_span") is HtmlControl lst_span)
    {
        var amount = ((TestDto)e.Item.DataItem).Amount;
        // lst_span.InnerText = amount.ToString();   // HtmlControl 無此 Property
        lst_span.Attributes["style"] = "background-color:" + GetBackGroundColor(amount);
    }
}
```