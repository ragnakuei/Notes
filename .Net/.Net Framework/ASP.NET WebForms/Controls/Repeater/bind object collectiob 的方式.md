# bind object collectiob 的方式.md

-   給定 item.PropertyName 的方式

    ```html
    <%# DataBinder.Eval(Container.DataItem, "PropertyName") %>
    ```

完整範例：

```cs
rep_items.DataSource = new []{ 
    new Dto { Name = "A", },
    new Dto { Name = "B", },
    new Dto { Name = "C", },
}.Split(',');
rep_items.DataBind();
```

```html
<asp:Repeater ID="rep_items" runat="server">
    <ItemTemplate>
        <tr>
            <td><%# DataBinder.Eval(Container.DataItem, "Name") %></td>
            <td><asp:Label id="lblCountry" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>' /></td>
        <tr>
    </ItemTemplate>
</asp:Repeater>
```
