# bind string array 的方式

- 給定 item 的方式

    ```html
    <%# Container.DataItem %>
    ```

完整範例：

```cs
rep_items.DataSource = new []{ "A", "B", "C" }.Split(',');
rep_items.DataBind();
```

```html
<asp:Repeater ID="rep_items" runat="server">
    <ItemTemplate>
        <span class="badge-outline">
            <asp:Literal runat="server" Text="<%# Container.DataItem %>"></asp:Literal>
        </span>
    </ItemTemplate>
</asp:Repeater>
```