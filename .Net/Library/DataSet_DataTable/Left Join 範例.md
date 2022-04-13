# Left Join 範例

## 範例一

```cs
var leftDt = new DataTable();
leftDt.Columns.Add("Id",   typeof(int));
leftDt.Columns.Add("Name", typeof(string));
leftDt.Columns.Add("Age",  typeof(int));
leftDt.Rows.Add(1, "John", 20);
leftDt.Rows.Add(2, "Mary", null);
leftDt.Rows.Add(3, "Mike", null);

var rightDt = new DataTable();
rightDt.Columns.Add("Id",   typeof(int));
rightDt.Columns.Add("Name", typeof(string));
rightDt.Columns.Add("Age",  typeof(int));
rightDt.Rows.Add(2, "Mary", 21);
rightDt.Rows.Add(3, "Mike", 22);
rightDt.Rows.Add(4, "John", 20);
rightDt.Rows.Add(5, "Mary", 21);

var result = leftDt.AsEnumerable()
                    .Select(leftRow =>
                            {
                                var jointRow = rightDt
                                                .AsEnumerable()
                                                .FirstOrDefault(rightRow => leftRow.Field<int?>("Id")     == rightRow.Field<int?>("Id")
                                                                         && leftRow.Field<string>("Name") == rightRow.Field<string>("Name"));

                                leftRow.SetField("Age", leftRow.Field<int?>("Age") ?? jointRow.Field<int?>("Age"));
                                return leftRow;
                            })
                    .CopyToDataTable();

result.Dump();
```

## 範例二:IEqualityComparer

```cs
var leftDt = new DataTable();
leftDt.Columns.Add("Id",   typeof(int));
leftDt.Columns.Add("Name", typeof(string));
leftDt.Columns.Add("Age",  typeof(int));
leftDt.Rows.Add(1, "John", 20);
leftDt.Rows.Add(2, "Mary", null);
leftDt.Rows.Add(3, "Mike", null);

var rightDt = new DataTable();
rightDt.Columns.Add("Id",   typeof(int));
rightDt.Columns.Add("Name", typeof(string));
rightDt.Columns.Add("Age",  typeof(int));
rightDt.Rows.Add(2, "Mary", 21);
rightDt.Rows.Add(3, "Mike", 22);
rightDt.Rows.Add(4, "John", 20);
rightDt.Rows.Add(5, "Mary", 21);

var result = leftDt.AsEnumerable()
                    .Select(leftRow =>
                            {
                                var jointRow = rightDt
                                                .AsEnumerable()
                                                .FirstOrDefault(rightRow => new IdNameDataRowComparer().Equals(leftRow, rightRow));

                                leftRow.SetField("Age", leftRow.Field<int?>("Age") ?? jointRow.Field<int?>("Age"));
                                return leftRow;
                            })
                    .CopyToDataTable();

result.Dump();


public class IdNameDataRowComparer : IEqualityComparer<DataRow>
{
    public bool Equals(DataRow x, DataRow y)
    {
        var xId = x.Field<int>("Id");
        var yId = y.Field<int>("Id");
        var xName = x.Field<string>("Name");
        var yName = y.Field<string>("Name");

        return xId == yId
            && xName == yName;
    }

    public int GetHashCode(DataRow obj)
    {
        unchecked
        {
            var hashCode = (obj.RowError != null ? obj.RowError.GetHashCode() : 0);
            hashCode = (hashCode * 397) ^ (int)obj.RowState;
            hashCode = (hashCode * 397) ^ obj.Table.GetHashCode();
            hashCode = (hashCode * 397) ^ obj.ItemArray.GetHashCode();
            hashCode = (hashCode * 397) ^ obj.HasErrors.GetHashCode();
            return hashCode;
        }
    }
}
```