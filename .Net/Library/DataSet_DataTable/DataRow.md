# DataRow

## 強型別

取值
- row.Field<int>("Id");

給值
- row.SetField("Id", 1);


## IEnumerable\<DataRow> 轉成 DataTable

- IEnumerable\<DataRow>.CopyToDataTable()

```cs
var leftDt = new DataTable();
leftDt.Columns.Add("Id", typeof(int));
leftDt.Columns.Add("Name", typeof(string));
leftDt.Columns.Add("Age", typeof(int));
leftDt.Rows.Add(1, "John", 20);
leftDt.Rows.Add(2, "Mary", null);
leftDt.Rows.Add(3, "Mike", null);

leftDt.AsEnumerable().CopyToDataTable().Dump();
```