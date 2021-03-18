#

```csharp
            var sql = @"
INSERT INTO [dbo].[NewsLetter]([Guid],
                               [ContentLinkSourceTypeId],
                               [Title],
                               [CreateTime],
                               [CreatorGuid])
VALUES (NEWID(),
        @ContentLinkSourceTypeId,
        @Title,
        @UpdateTime,
        @UpdatorGuid)
";
            var param = new DynamicParameters();
            param.Add("Title",                   formDto.Title,                   DbType.String, size: 200);
            param.Add("ContentLinkSourceTypeId", formDto.ContentLinkSourceTypeId, DbType.Int64);
            param.Add("UpdateTime",              DateTime.Now,                    DbType.DateTime2);
            param.Add("UpdatorGuid",             formDto.UpdatorGuid,             DbType.Guid);

            param.Add("NewsLetterDetail",
                      formDto.Details
                             .ToDataTable()
                             .AsTableValuedParameter("[dbo].[ut_NewsLetterDetail]"));

            _dbConnection.Execute(sql, param);
```

```csharp
/// <summary>
/// 用來標示不需要在 DataTableHelper 轉成 DataColumn !
/// </summary>
public class IgnoreDataTableAttribute : Attribute
{
}

public static class DataTableHelpers
{
    public static DataTable ToDataTable<T>(this IEnumerable<T> objs)
    {
        var dt = new DataTable();

        var propertyInfos = typeof(T).GetProperties()
                                     .Where(p => p.GetCustomAttribute<IgnoreDataTableAttribute>() == null);

        foreach (var p in propertyInfos)
        {
            var dc = new DataColumn(p.Name, Nullable.GetUnderlyingType(p.PropertyType) ?? p.PropertyType);
            dc.AllowDBNull = true;
            dt.Columns.Add(dc);
        }

        foreach (T entity in objs)
        {
            DataRow dr = dt.NewRow();

            foreach (PropertyInfo p in propertyInfos)
            {
                var value = p.GetValue(entity);
                dr[p.Name] = value ?? DBNull.Value;
            }

            dt.Rows.Add(dr);
        }

        return dt;
    }
}
```