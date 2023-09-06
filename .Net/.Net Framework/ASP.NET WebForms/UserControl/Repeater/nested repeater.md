# nested repeater

```cs
<tbody>
    <asp:Repeater ID="repList"
                    runat="server">
        <ItemTemplate>
            <tr>
                <td><%# Eval("Name") %></td>
                <td><%# Eval("Age") %></td>
                <td>
                    <asp:Repeater runat="server"
                                  DataSource='<%# GetChildren(Eval("id").ToString()) %>'>
                        <ItemTemplate>
                            <a href = "~/Products/products.aspx?pr_tp_sn=<%= Eval("id") %>" ><%= Eval("id") %></a>
                        </ItemTemplate>
                        <SeparatorTemplate>
                            <br />
                        </SeparatorTemplate>
                    </asp:Repeater>
                </td>
                <td>
                    
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
</tbody>
```
其中 

```cs
protected DataTable(string id)
{
    return new DataTable();
}
```