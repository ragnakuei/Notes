# DataSet 設定關聯的方式

```csharp
void Main()
{
	// 關聯的 Datatable 要放在 DataSet 中

	var ds = new DataSet();

	var dtCustomers = GetCustomerDataTable();
	ds.Tables.Add(dtCustomers);

	var dtOrder = GetOrderDataTable();
	ds.Tables.Add(dtOrder);

	// 關聯設定 1 對 多
	//var relation = new DataRelation("FK_Order_CustomerID_Customer_Id", dtOrder.Columns["CustomerId"], dtCustomers.Columns["Id"]);
	var relation = new DataRelation("FK_Customer_Id_Order_CustomerID", ds.Tables["Customer"].Columns["Id"], ds.Tables["Order"].Columns["CustomerId"]);

	// 可以在 datatable 中指定
	//dtOrder.ChildRelations.Add(relation);

	ds.Dump();

	// 也可以在 ds 中指定
	ds.Relations.Add(relation);

	// 取出資料 ----------------------------

	//ds.Tables["Customer"].Dump();
	//ds.Tables["Order"].Dump();

	//dtOrder.Rows[0].Dump();
	//dtOrder.Rows[0].GetChildRows(relation).Dump();

    // 以關聯方式取出
    //	for (int i = 0; i < ds.Tables["Customer"].Rows.Count; i++)
    //	{
    //		"Customer".Dump();
    //		ds.Tables["Customer"].Rows[i].Dump();
    //
    //		"Order".Dump();
    //		ds.Tables["Customer"].Rows[i].GetChildRows(relation).Dump();
    //		"-------------------------------------".Dump();
    //	}


	// 以 LINQ 建立關聯
	var joinResult = (from customer in ds.Tables["Customer"].Rows.Cast<DataRow>()
					  join order in ds.Tables["Order"].Rows.Cast<DataRow>()
					      on customer["Id"] equals order["CustomerId"] into customerJoinOrder
					  from cjo in customerJoinOrder.DefaultIfEmpty()
					  select new { customer, cjo })
					  .GroupBy(r => r.customer)
					  .ToDictionary(r => r.Key,
					                v => v.Select(r => r.cjo).ToArray());
	joinResult.Dump();
}

private DataTable GetCustomerDataTable()
{
	var dtCustomers = new DataTable("Customer");
	dtCustomers.Columns.Add("Id", typeof(Int32));
	dtCustomers.Columns.Add("Name", typeof(String));

	dtCustomers.PrimaryKey = new[] { dtCustomers.Columns["Id"] };

	var row = dtCustomers.NewRow();
	row[0] = 1;
	row[1] = "CustomerNameA";
	dtCustomers.Rows.Add(row);

	row = dtCustomers.NewRow();
	row[0] = 2;
	row[1] = "CustomerNameB";
	dtCustomers.Rows.Add(row);

	row = dtCustomers.NewRow();
	row[0] = 3;
	row[1] = "CustomerNameC";
	dtCustomers.Rows.Add(row);

	return dtCustomers;
}

private DataTable GetOrderDataTable()
{
	var dtOrder = new DataTable("Order");
	dtOrder.Columns.Add("Id", typeof(Int32));
	dtOrder.Columns.Add("Name", typeof(String));
	dtOrder.Columns.Add("CustomerId", typeof(Int32));

	dtOrder.PrimaryKey = new[] { dtOrder.Columns["Id"] };

	var row = dtOrder.NewRow();
	row[0] = 1;
	row[1] = "OrderNameA";
	row[2] = 1;
	dtOrder.Rows.Add(row);

	row = dtOrder.NewRow();
	row[0] = 2;
	row[1] = "OrderNameB";
	row[2] = 1;
	dtOrder.Rows.Add(row);

	row = dtOrder.NewRow();
	row[0] = 3;
	row[1] = "OrderNameC";
	row[2] = 1;
	dtOrder.Rows.Add(row);

	row = dtOrder.NewRow();
	row[0] = 4;
	row[1] = "OrderNameE";
	row[2] = 2;
	dtOrder.Rows.Add(row);

	row = dtOrder.NewRow();
	row[0] = 5;
	row[1] = "OrderNameF";
	row[2] = 2;
	dtOrder.Rows.Add(row);

	row = dtOrder.NewRow();
	row[0] = 6;
	row[1] = "OrderNameG";
	row[2] = 3;
	dtOrder.Rows.Add(row);

	return dtOrder;
}
```
