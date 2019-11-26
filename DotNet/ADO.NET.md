# ADO.NET

- 讀取資料放至 DataSet 中

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
