# DataColumn


## Merge DataColumn

```cs
public DataTable MergeColumns(DataTable leftDt, DataTable rightDt, IEqualityComparer<DataColumn> comparer = null)
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


var leftDt = new DataTable();
leftDt.Columns.Add("Id", typeof(int));
leftDt.Columns.Add("Name", typeof(string));
leftDt.Columns.Add("Age", typeof(int));

var rightDt = new DataTable();
rightDt.Columns.Add("Id", typeof(int));
rightDt.Columns.Add("Name", typeof(string));
rightDt.Columns.Add("Age", typeof(int));
rightDt.Columns.Add("Address", typeof(string));

var result = MergeColumns(leftDt, rightDt);
result.Rows.Add(1, "A", 17, "A1");
result.Dump();
```