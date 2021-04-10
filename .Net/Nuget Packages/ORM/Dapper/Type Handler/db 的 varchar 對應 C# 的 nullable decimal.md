# db 的 varchar 對應 C# 的 nullable decimal.md

-   先宣告對應的 TypeHandler

    ```csharp
    /// <summary>
    /// db 的 varchar 對應 C# 的 decimal?
    /// </summary>
    public class ReadAnsiStringToNullDecimalHandler : SqlMapper.TypeHandler<decimal?>
    {
        // Read From Db
        public override decimal? Parse(object value)
        {
            return value?.ToString()?.ToNullableDecimal();
        }

        // Write To Db
        public override void SetValue(IDbDataParameter parameter, decimal? value)
        {
            parameter.Value  = value?.ToString();
            parameter.DbType = DbType.AnsiString;
        }
    }
    ```

-   使用方式

    ```csharp
    using (var conn = new SqlConnection(ConnectionString))
    {
        Dapper.SqlMapper.ResetTypeHandlers();
        Dapper.SqlMapper.AddTypeHandler(new ReadAnsiStringToNullDecimalHandler());

        var result = conn.Query<T>(sql, new DynamicParameter());
    }
    ```
