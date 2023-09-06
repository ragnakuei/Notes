# Left Join 範例

## 不相同 Column

### 範例一

```cs
public static class DataTableHelper
{
    public static DataTable MergeColumns(this DataTable leftDt, DataTable rightDt, IEqualityComparer<DataColumn> comparer = null)
    {
        comparer = comparer ?? new DataColumnComparer();

        var columns = leftDt.Columns.Cast<DataColumn>()
                            .Concat(rightDt.Columns.Cast<DataColumn>())
                            .Distinct(comparer)
                            .ToArray();

        var result = new DataTable();

        foreach (var column in columns)
        {
            result.Columns.Add(column.ColumnName, column.DataType);
        }

        return result;
    }

    public static DataTable LeftJoin(this DataTable leftDt, DataTable rightDt, IEqualityComparer<DataRow> comparer = null)
    {
        var result = leftDt.MergeColumns(rightDt);

        var columns = result.Columns.Cast<DataColumn>()
                            .Select(column => column.ColumnName)
                            .ToArray();
        var leftColumns = new HashSet<string>(leftDt.Columns.Cast<DataColumn>()
                                                    .Select(column => column.ColumnName));

        var rightColumns = new HashSet<string>(rightDt.Columns.Cast<DataColumn>()
                                                      .Select(column => column.ColumnName));


        foreach (var leftRow in leftDt.AsEnumerable())
        {
            var jointRows = rightDt.AsEnumerable()
                                   .Where(row => comparer.Equals(leftRow, row))
                                   .ToArray();

            if (jointRows.Any())
            {
                var resultRow = result.NewRow();

                foreach (var rightRow in jointRows)
                {
                    foreach (var column in columns)
                    {
                        object leftValue = null;

                        if (leftColumns.Contains(column))
                        {
                            leftValue = leftRow.Field<object>(column);
                        }

                        if (leftValue == null
                         && rightColumns.Contains(column))
                        {
                            leftValue = rightRow.Field<object>(column);
                        }

                        if (leftValue != null)
                        {
                            resultRow.SetField(column, leftValue);
                        }
                    }
                }

                result.Rows.Add(resultRow);
            }
            else
            {
                result.ImportRow(leftRow);
            }
        }

        return result;
    }

    public class DataColumnComparer : IEqualityComparer<DataColumn>
    {
        public bool Equals(DataColumn x, DataColumn y)
        {
            return x.ColumnName == y.ColumnName
                && Equals(x.DataType, y.DataType);
        }

        public int GetHashCode(DataColumn obj)
        {
            unchecked
            {
                var hashCode = obj.ColumnName.GetHashCode();
                hashCode = (hashCode * 397) ^ (obj.Caption != null ? obj.Caption.GetHashCode() : 0);
                hashCode = (hashCode * 397) ^ (obj.DataType != null ? obj.DataType.GetHashCode() : 0);
                return hashCode;
            }
        }
    }
}


var leftDt = new DataTable();
leftDt.Columns.Add("Id", typeof(int));
leftDt.Columns.Add("Name", typeof(string));
leftDt.Columns.Add("Age", typeof(int));
leftDt.Rows.Add(1, "John", 20);
leftDt.Rows.Add(2, "Mary", null);
leftDt.Rows.Add(3, "Mike", null);

var rightDt = new DataTable();
rightDt.Columns.Add("Id", typeof(int));
rightDt.Columns.Add("Name", typeof(string));
rightDt.Columns.Add("Age", typeof(int));
rightDt.Columns.Add("Address", typeof(string));
rightDt.Rows.Add(2, "Mary", 21, "M1");
rightDt.Rows.Add(2, "Mary", 21, "M2");
rightDt.Rows.Add(3, "Mike", 22, "M1");
rightDt.Rows.Add(4, "John", 20, "J3");
rightDt.Rows.Add(5, "Mary", 21, "M1");

var result = leftDt.LeftJoin(rightDt, new IdNameDataRowComparer());
result.Dump();
```

## 相同 Column

### 範例一

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

### 範例二:IEqualityComparer

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