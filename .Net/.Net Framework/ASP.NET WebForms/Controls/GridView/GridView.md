# [GridView](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.webcontrols.gridview)

## Sample

```csharp
protected void Page_Load(object sender, EventArgs e)
{
    var orderListFromDb = _orderService?.GetOrderList();
    orderList.DataSource = orderListFromDb;
    orderList.DataBind();    // 給定 DataSource 後，要記得做 DataBind() 才會顯示資料
}
```

注意：
> 呼叫 DataBind() 時，要確認 GridView 內的欄位，不可以有 BoundField 不存在於 DataTable 的欄位，否則會有 Exception

> 如果需要做管理欄位，直接用 TemplateField 就可以了 !

```html
<asp:GridView
  ID="orderList"
  runat="server"
  AutoGenerateColumns="false"
  CssClass="table"
  EmptyDataText="No data available."
>
  <Columns>
    <asp:TemplateField HeaderText="OrderID" InsertVisible="False">
      <EditItemTemplate>
        <asp:TextBox
          ID="Label1"
          runat="server"
          Text='<%# Eval("OrderID") %>'
        ></asp:TextBox>
      </EditItemTemplate>
      <ItemTemplate>
        <asp:Label
          ID="Label1"
          runat="server"
          Text='<%# Bind("OrderID") %>'
        ></asp:Label>
      </ItemTemplate>
    </asp:TemplateField>
  </Columns>
</asp:GridView>
```

---

## Attribute

- ID

  Table 的 ID

- CssClass

  Table 的 css class

- EmptyDataText

- AutoGenerateColumns

  | 值    | 功能                                           |
  | ----- | ---------------------------------------------- |
  | true  | 可以從 DataTable Column 取出欄位名稱來顯示資料 |
  | false | 只會從設定的 asp:BoundField 來顯示欄位         |
