# 以 IN 方式查詢

目前查到沒有像 Dapper 可以直接支援 IN 的查詢

解法：

> 透過動態產生 SqlParameter & 語法的方式

```csharp
public class Program
{
    public static void Main(string[] args)
    {
        var ids = new List<string>();

        using (SqlConnection cn = new SqlConnection())
        {
            cn.ConnectionString = "Server=.\\mssql2017;Database=Northwind;Trusted_Connection=True;MultipleActiveResultSets=true";
            cn.Open();

            var cmd = new SqlCommand(@"
select p.ProductID
from Products p
where p.ProductID IN ({productIds})
            ", cn);
            cmd.AddArrayParameters("productIds", new int[]
            {
                1,
                2,
                3
            });
            var dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                ids.Add(dr[0].ToString());
            }

            cn.Close();
        }

        foreach (var id in ids)
        {
            Console.WriteLine(id);
        }
    }
}

public static class SqlCommandExt
{
    /// <summary>
    /// 透過取代 SqlCommandText {paramNameRoot} 的方式，來達成支援 IN 的查詢
    /// </summary>
    public static SqlParameter[] AddArrayParameters<T>(this SqlCommand cmd,
                                                        string paramNameRoot,
                                                        IEnumerable<T> values,
                                                        SqlDbType? dbType = null,
                                                        int? size = null)
    {
        var parameters = new List<SqlParameter>();
        var parameterNames = new List<string>();
        var paramNbr = 1;
        foreach (var value in values)
        {
            var paramName = string.Format("@{0}{1}", paramNameRoot, paramNbr++);
            parameterNames.Add(paramName);
            
            var p = new SqlParameter(paramName, value);
            
            if (dbType.HasValue)
            {
                p.SqlDbType = dbType.Value;
            }

            if (size.HasValue)
            {
                p.Size = size.Value;
            }

            cmd.Parameters.Add(p);
            parameters.Add(p);
        }

        cmd.CommandText = cmd.CommandText.Replace("{" + paramNameRoot + "}", string.Join(",", parameterNames));
        return parameters.ToArray();
    }
}
```

