# 產生 Insert Sql 語法

```csharp
void Main()
{
    this.Connection
//.DumpClass
.DumpInsertIntoSqlScript
(@"
    select * from CompCv
").Dump();

}

public static class LINQPadExtensions
{
    private static readonly Dictionary<Type, string> TypeAliases = new Dictionary<Type, string> {
        { typeof(int), "int" },
        { typeof(short), "short" },
        { typeof(byte), "byte" },
        { typeof(byte[]), "byte[]" },
        { typeof(long), "long" },
        { typeof(double), "double" },
        { typeof(decimal), "decimal" },
        { typeof(float), "float" },
        { typeof(bool), "bool" },
        { typeof(string), "string" }
    };

    private static readonly HashSet<Type> NullableTypes = new HashSet<Type> {
        typeof(int),
        typeof(short),
        typeof(long),
        typeof(double),
        typeof(decimal),
        typeof(float),
        typeof(bool),
        typeof(DateTime)
    };

    /// <summary>
    /// 依照輸入的 SQL 所產生的結構來產生 Insert Sql Script
    /// </summary>
    public static string DumpInsertIntoSqlScript(this IDbConnection connection, string sql)
    {
        if (connection.State != ConnectionState.Open)
            connection.Open();

        var cmd = connection.CreateCommand();
        cmd.CommandText = sql;
        var reader = cmd.ExecuteReader();

        var builder = new StringBuilder();
        builder.Append("INSERT INTO JoinTableName (");
        do
        {
            if (reader.FieldCount <= 1) continue;

            var schema = reader.GetSchemaTable();

            var columnNames = new List<string>();
            foreach (DataRow row in schema.Rows)
            {
                var columnName = (string)row["ColumnName"];

                columnNames.Add(columnName);
            }
            builder.Append(string.Join(",", columnNames));
        } while (reader.NextResult());
        builder.AppendLine($@")");
        builder.Append("VALUES()");
        return builder.ToString();
    }
}
```