# Filter 範例

提供二個方式
- LINQ Where
- DataView.RowFilter

```cs
void Main()
{
	var dt = new DataTable();
	
	dt.Columns.Add("Id", typeof(int));
	dt.Columns.Add("Name", typeof(string));
	
	Enumerable.Range(1, 10)
	.ForEach(i =>
	{
		dt.Rows.Add(i, (char)(i + 64));
	});
	
	dt.Dump();
	
	var dt2 = Filter(dt, row => row.Field<int>("Id") > 10);
	dt2.Dump();

	var dt3 = Filter2(dt, "Id > 9");
	dt3.Dump("dt3");
}

public DataTable Filter(DataTable dt, Predicate<DataRow> predicate)
{
	var result = dt.Clone();

	foreach (DataRow row in dt.Rows)
	{
		if (predicate(row))
		{
			var resultRow = result.NewRow();
			resultRow .ItemArray = row.ItemArray.Clone() as object[];
			result.Rows.Add(resultRow);
		}
	}

	return result;
}

public DataTable Filter2(DataTable dt, string predicate)
{
	var dv = new DataView(dt);
	dv.RowFilter = predicate;

	return dv.ToTable();
}
```