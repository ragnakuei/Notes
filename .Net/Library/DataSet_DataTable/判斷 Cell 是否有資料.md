# 判斷 Cell 是否有資料

```cs
var columnName = DataRow.Field<T>(ColumnName) 
// 後續就看該型別的判斷了 !
```

```cs
if(DataRow[Column] == DBNull.Value)
{
    // 後續處理
}
```
