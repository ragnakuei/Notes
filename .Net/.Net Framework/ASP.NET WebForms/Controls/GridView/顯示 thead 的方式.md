# 顯示 thead 的方式

- 給定 ShowHeader="true"

    ```html
    <asp:GridView
    ID="orderList"
    runat="server"
    AutoGenerateColumns="false"
    CssClass="table"
    ShowHeader="true"
    >
    <Columns>
        <asp:BoundField
        DataField="OrderID"
        HeaderText="OrderID"
        InsertVisible="False"
        ReadOnly="True"
        />
    </Columns>
    </asp:GridView>
    ```

- 程式碼加上判斷

    ```csharp
    protected void Page_Load(object sender, EventArgs e)
    {
        var orderListFromDb = _orderService?.GetOrderList();
        orderList.DataSource = orderListFromDb;
        orderList.DataBind();

        if ((orderList.ShowHeader == true
          && orderList.Rows.Count > 0)
            || (orderList.ShowHeaderWhenEmpty == true))
        {
            orderList.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }
    ```
