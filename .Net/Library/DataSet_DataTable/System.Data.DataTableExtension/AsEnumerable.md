# AsEnumerable

```cs
public string Test(DataTable dt, int id)
{
    var row = dt.AsEnumerable().FirstOrDefault(r => r.Field<int>("Id") == id );
    
    return row.Field<string>("Name");
}
```