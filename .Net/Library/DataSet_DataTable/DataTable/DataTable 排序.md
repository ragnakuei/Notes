# DataTable 排序

##### 方式一：

```cs
var dt = new DataTable();
dt.Columns.Add("Id", typeof(string));
dt.Columns.Add("Name", typeof(string));
dt.Columns.Add("EngName", typeof(string));

dt.Rows.Add("2", "三", "A");
dt.Rows.Add("1", "二", "C");
dt.Rows.Add("3", "一", "B");

// 給定排序條件
dt.DefaultView.Sort = "Id DESC";

// 要再轉成 DataTable 才會排序
var dt2 = dt.DefaultView.ToTable();

dt2.Dump();
```

##### 方式二：

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