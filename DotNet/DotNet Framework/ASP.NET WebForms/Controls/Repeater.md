# [Repeater](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.webcontrols.repeater)

DataSource 可用於 ItemTemplate 的 DataBind

各區塊

- HeaderTemplate
- FooterTemplate
- ItemTemplate - Data 內各 Row 的資料
- SeparatorTemplate - 各 Row 之間的間隔

```html
<asp:Repeater ID="Repeater1" runat="server">
  <HeaderTemplate>
    <p>Header</p>
  </HeaderTemplate>

  <ItemTemplate>
    <p>Item<%# Eval("Id") %></p>
  </ItemTemplate>
  <SeparatorTemplate>
    <hr />
  </SeparatorTemplate>
  <FooterTemplate>
    <p>Fotter</p>
  </FooterTemplate>
</asp:Repeater>
```

```csharp
protected void Page_Load(object sender, EventArgs e)
{
    var dt = new DataTable();
    dt.Columns.Add("Id", typeof(int));

    foreach (var i in Enumerable.Range(1,3))
    {
        var row = dt.NewRow();
        row[0] = i;
        dt.Rows.Add(row);
    }

    Repeater1.DataSource = dt;
    Repeater1.DataBind();
}
```

Render 出來的 Html

```html
<p>Header</p>
<p>Item1</p>
<hr />
<p>Item2</p>
<hr />
<p>Item3</p>
<p>Footer</p>
```
