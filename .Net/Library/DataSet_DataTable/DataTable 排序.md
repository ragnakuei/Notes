# DataTable 排序

```cs
/// <summary>
/// 對 DataTable 做排序
/// </summary>
public static DataTable sort<TKey>(DataTable dt, Func<DataRow, TKey> orderBy, Func<DataRow, TKey> orderByDescending)
{
    if (dt.Rows.Count > 0)
    {
        var action = dt.AsEnumerable();
        if (orderBy != null)
        {
            action = action.OrderBy(orderBy);
        }

        if (orderByDescending != null)
        {
            action = action.OrderByDescending(orderByDescending);
        }

        var sorted_dt = action.CopyToDataTable();
        return sorted_dt;
    }

    return dt;
}
```