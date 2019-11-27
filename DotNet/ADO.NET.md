# ADO.NET

## 透過 SqlDataAdapter 讀取資料放至 DataSet 中

可支援 multiple result sets

```csharp
var queryResult = new DataSet();
using (SqlConnection connection = new SqlConnection(_connectionString))
{
    var command = new SqlCommand(sql, connection);

    try
    {
        connection.Open();
        var da = new SqlDataAdapter(command);
        da.Fill(queryResult);
        connection.Close();
        da.Dispose();
    }
    catch (Exception ex)
    {
        connection.Close();
        throw ex;
    }
}

return queryResult.Tables[0];
```

---

## 透過 SqlDataAdapter 讀取資料放至 DataTable 中

```csharp
public DataTable GetOrderListToDataTable(int pageIndex, int pageSize)
{
    var sql = @"
DECLARE @OrderIds table
            (
                OrderID int
            )

INSERT INTO @OrderIds(OrderID)
SELECT OrderID
FROM dbo.Orders
ORDER BY OrderID
OFFSET @skipCount ROWS
FETCH NEXT @pageSize ROWS ONLY;

SELECT *
FROM dbo.Orders o
JOIN @OrderIds oIds
    ON oIds.OrderID = o.OrderID
JOIN (
            SELECT od.OrderID, COUNT(0) AS DetailCOunt
            FROM dbo.[Order Details] od
            GROUP BY od.OrderID
        ) dc
        on dc.OrderID = o.OrderID
";
    var queryResult = new DataTable();
    using (SqlConnection connection = new SqlConnection(_connectionString))
    {
        var command = new SqlCommand(sql, connection);
        command.Parameters.AddRange(
            new SqlParameter[]
            {
                new SqlParameter("@skipCount", SqlDbType.Int){ Value = (pageIndex * pageSize)},
                new SqlParameter("@pageSize", pageSize){ Value = pageSize },
            }
        );

        SqlDataReader dr = null;

        try
        {
            if (connection.State != ConnectionState.Open)
            {
                connection.Open();
            }

            dr = command.ExecuteReader();
            queryResult.Load(dr);

            if (connection.State != ConnectionState.Closed)
            {
                connection.Close();
            }
        }
        catch (Exception ex)
        {
            if (connection.State != ConnectionState.Closed)
            {
                connection.Close();
            }
            throw ex;
        }
    }

    return queryResult;
}
```
