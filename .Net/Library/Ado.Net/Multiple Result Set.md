# Multiple Result Set.md

## 透過 SqlDataAdapter 讀取資料放至 DataSet 中 (一)

```csharp
    var connectionString = Utility.GetConnectionString("xxx");

    using (var connection = new SqlConnection(connectionString))
    {
        try
        {
            var result = new CheckItemInfoDto();
            result.EmpNo        = EmpNo;
            result.CheckItemNos = new HashSet<int>();

            connection.Open();

            var sqlCommand = connection.CreateCommand();
            sqlCommand.Connection = connection;
            sqlCommand.CommandText = @"
SELECT *
FROM [CheckItemInfo]
WHERE [EmpNo] = @EmpNo

SELECT COUNT(0) AS [TotalEmpNoCount]
FROM (
    SELECT COUNT(0) AS [GroupByEmpNo]
    FROM [CheckItemInfo]
    GROUP BY [EmpNo]
) [groupByEmpNo]

SELECT COUNT(0) AS [TotalCount]
FROM [CheckItemInfo]
";
            sqlCommand.CommandType                                           = CommandType.Text;
            sqlCommand.Parameters.Add("EmpNo", SqlDbType.NVarChar, 50).Value = EmpNo;

            var sqlDataAdapter = new SqlDataAdapter(sqlCommand);

            var ds = new DataSet();
            sqlDataAdapter.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    var checkItemNo = Utility.ToNullableInt(row["CheckItemNo"]);
                    if (checkItemNo.HasValue)
                    {
                        result.CheckItemNos.Add(checkItemNo.Value);
                    }
                }
            }

            result.TotalEmpNoCount = Utility.ToNullableInt(ds.Tables[1].Rows[0]["TotalEmpNoCount"]);

            result.TotalCount = Utility.ToNullableInt(ds.Tables[2].Rows[0]["TotalCount"]);

            return result;
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            Console.WriteLine(e.StackTrace);
            Console.WriteLine(e.Message);
            throw;
        }
        finally
        {
            connection.Close();
        }
    }
```

## 透過 SqlDataAdapter 讀取資料放至 DataSet 中 (二)

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

---

## multiple result sets 讀取至不同的 DataTable 中

-   DataTable.Load(SqlDataReader) 包含了 SqlDataReader.NextResult()

```csharp
public OrderListDataTable GetOrderListToDataTable(int pageIndex, int pageSize)
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

SELECT count(0) as TotalCount
FROM dbo.orders
";
    var queryResult = new DataTable();
    var queryTotalCount = new DataTable();

    using (SqlConnection connection = new SqlConnection(_connectionString))
    {
        var command = new SqlCommand(sql, connection);
        command.Parameters.AddRange(
            new SqlParameter[]
            {
                new SqlParameter("@skipCount", SqlDbType.Int){ Value = (pageIndex * pageSize)},
                new SqlParameter("@pageSize", pageSize){ Value = pageSize},
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
            queryTotalCount.Load(dr);

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

    var result = new OrderListDataTable
                    {
                        TotalCount = queryTotalCount.Rows[0][0].ToInt32(),
                        Items = queryResult
                    };
    return result;
}
```


