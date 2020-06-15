# 產生 Sql 語法對應的 Class (支援 Join)

http://kevintsengtw.blogspot.com/2015/10/dapper-linqpad-sql-command.html

```csharp
void Main()
{
	this.Connection
	.DumpClass("SELECT * FROM COMP_DeptLevel")
	.Dump();
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
		typeof(DateTime),
		typeof(Guid)
	};

	public static string DumpClass(this IDbConnection connection, string sql)
	{
		if (connection.State != ConnectionState.Open)
			connection.Open();

	var cmd = connection.CreateCommand();
	cmd.CommandText = sql;
	var reader = cmd.ExecuteReader();

	var builder = new StringBuilder();
	do
	{
		if (reader.FieldCount <= 1) continue;

	builder.AppendLine("public class Info");
	builder.AppendLine("{");
	var schema = reader.GetSchemaTable();

	foreach (DataRow row in schema.Rows)
	{
		var type = (Type)row["DataType"];
		var name = TypeAliases.ContainsKey(type) ? TypeAliases[type] : type.Name;
		var isNullable = (bool)row["AllowDBNull"] && NullableTypes.Contains(type);
		var collumnName = (string)row["ColumnName"];

	    builder.AppendLine(string.Format("\tpublic {0}{1} {2} {{ get; set; }}", name, isNullable ? "?" : string.Empty, collumnName));
	}

	builder.AppendLine("}");
	builder.AppendLine();
	} while (reader.NextResult());

	return builder.ToString();
	}
}
```
