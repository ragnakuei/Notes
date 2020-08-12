# 從 excel 的 dd 宣告來產生對應語法

## excel 欄位宣告

共六個欄位

```
欄位英文名稱	資料型態	是否允許 Null	欄位中文名稱	主鍵(P)/次鍵(Sn)/外鍵(Fn)	定義域/說明
```

## 轉成 SQL

未建立 Relation 的關係的對應語法

```sql
private const string DefaultSchema = "dbo";
private const string TableName = "Role";

void Main()
{
	var columnDefinitions = @"Id	bigint	No	ID	P
Name	nvarchar(50)	No	名稱
Value	nvarchar(50)	No	值		";


	var lines = SplitLine(columnDefinitions);
	var dtos = SplitColumnsToColumnDto(lines);
	var result = ColumnDtoToSqlCreateScript(dtos);
	result.Dump();
}

private IEnumerable<string> SplitLine(string columnDefinitions)
{
	return columnDefinitions.Split("\r\n");
}

private IEnumerable<ColumnDto> SplitColumnsToColumnDto(IEnumerable<string> lines)
{
	return lines.Select(l => ToColumnDto(l.Split("\t")));
}

private ColumnDto ToColumnDto(string[] columns)
{
	return new ColumnDto
	{
		Name = columns[0],
		Type = ToType(columns[1]),
		Nullable = ToNullable(columns[2]),
		Description = columns[3],
	};
}

private string[] _addSquareBracketsTypes = new[]{
		// 要注意順序
		"nvarchar",
		"varchar",
		"datetime2",
	};
private string ToType(string t)
{
	foreach (var addSquareBracketsType in _addSquareBracketsTypes)
	{
		if (t.Contains(addSquareBracketsType))
		{
			var result = t.Replace(addSquareBracketsType, $"[{addSquareBracketsType}]");
			return result;
		}
	}

	return $"[{t}]";
}

private string ToNullable(string column)
{
	if (column == "Yes")
	{
		return "NULL";
	}

	return "NOT NULL";
}

private string ColumnDtoToSqlCreateScript(IEnumerable<ColumnDto> dtos)
{
	var createScript = new StringBuilder();
	createScript.Append($@"
CREATE TABLE [{DefaultSchema}].[{TableName}] (
");

	var createDescriptionScript = new StringBuilder();

	dtos.ForEach(dto =>
	{

		createScript.Append($@"
	[{dto.Name}] {dto.Type} {dto.Nullable},
	");

		createDescriptionScript.AppendLine(CreateDescriptionScript(dto));
	});

	createScript.Append($@"
	)  ON [PRIMARY]
GO
");

	return createScript.ToString() + createDescriptionScript.ToString();
}

private string CreateDescriptionScript(ColumnDto dto)
{
	return @$"EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'{dto.Description}' , @level0type=N'SCHEMA',@level0name=N'{DefaultSchema}', @level1type=N'TABLE',@level1name=N'{TableName}', @level2type=N'COLUMN',@level2name=N'{dto.Name}'
GO";
}

public class ColumnDto
{
	public string Name { get; set; }
	public string Type { get; set; }
	public string Nullable { get; set; }
	public string Description { get; set; }
}
```

## 轉成 Ef Core Fluent API

如果是自體關聯的話，可能需要在產生後改成以下語法

```csharp
builder.HasOne(x => x.Creater)
       .WithOne()
       .IsRequired()
       .HasPrincipalKey<User>(x => x.Guid)
       .HasConstraintName($"IX_{nameof(User)}_{nameof(User.CreateGuid)}_{nameof(User)}_{nameof(User.Guid)}")
       .OnDelete(DeleteBehavior.NoAction);
```

```csharp
// ForeignKeyDefinitions 目前只支援 one to one
// one to many 還沒想到怎麼做

private const string DefaultSchema = "dbo";
private const string TableName = "Role";
private const string SqlDbTypesName = "SqlDbTypes";

void Main()
{
	var columnDefinitions = @"Id	bigint	No	ID	P
Name	nvarchar(50)	No	名稱
Value	nvarchar(50)	No	值		";


	var lines = SplitLine(columnDefinitions);
	var dtos = SplitColumnsToColumnDto(lines);
	dtos.Dump();
	var result = ColumnDtoToFluentApiSyntax(dtos);
	result.Dump();
}

private IEnumerable<string> SplitLine(string columnDefinitions)
{
	return columnDefinitions.Split("\r\n");
}

private IEnumerable<ColumnDto> SplitColumnsToColumnDto(IEnumerable<string> lines)
{
	return lines.Select(l => ToColumnDto(l.Split("\t")));
}

private ColumnDto ToColumnDto(string[] columns)
{
	var result = new ColumnDto
	{
		Name = columns[0],
		Type = columns[1],
		Nullable = ToNullable(columns[2]),
		Description = columns[3],
	};

	if (string.IsNullOrWhiteSpace(columns[5]) == false)
	{
		var foreignKeyParts = columns[5].Split('.');
		result.ForeignKeyTable = foreignKeyParts[0];
		result.ForeignKeyTableColumnName = foreignKeyParts[1];
	}

	return result;
}

private bool ToNullable(string column)
{
	if (column.Equals("No", StringComparison.CurrentCultureIgnoreCase))
	{
		return false;
	}

	return true;
}

private string ColumnDtoToFluentApiSyntax(IEnumerable<ColumnDto> dtos)
{
	var columnDefinitions = new StringBuilder();
	var foreignKeyOneToOneDefinitions = new StringBuilder("// 以下是 FK 設定");

	dtos.ForEach(dto =>
	{
		columnDefinitions.Append(GeneratePropertyFluentApiSyntax(dto));
		AddForeignKeyOneToOneDefinitions(foreignKeyOneToOneDefinitions, dto);
	});

	return columnDefinitions.ToString() + foreignKeyOneToOneDefinitions.ToString();
}

private string GeneratePropertyFluentApiSyntax(ColumnDto dto)
{
	var result = new StringBuilder();
	result.AppendLine($"builder.Property(x => x.{dto.Name})");

	if (dto.Nullable == false)
	{
		result.AppendLine(".IsRequired()");
	}

	result.AppendLine($".HasColumnType({SqlDbTypesName}.{dto.Type.ToFirstCharUpperCase()})");

	result.AppendLine($".HasComment(\"{dto.Description}\");");

	result.AppendLine();

	return result.ToString();
}

void AddForeignKeyOneToOneDefinitions(StringBuilder foreignKeyDefinitions, ColumnDto dto)
{
	if(string.IsNullOrWhiteSpace(dto.ForeignKeyTable))
	{
		return;
	}

	foreignKeyDefinitions.Append($@"
            builder.HasOne(x => x.{dto.ForeignKeyTable})
                   .WithOne()
                   .IsRequired()
                   .HasConstraintName($""IX_{{nameof({TableName})}}_{{nameof({TableName}.{dto.Name})}}_{{nameof({dto.ForeignKeyTable})}}_{{nameof({dto.ForeignKeyTable}.{dto.ForeignKeyTableColumnName})}}"")
				   .HasForeignKey<{dto.ForeignKeyTable}>(x => x.{dto.ForeignKeyTableColumnName});
	");
}

public class ColumnDto
{
	public string Name { get; set; }
	public string Type { get; set; }
	public bool Nullable { get; set; }
	public string Description { get; set; }

	public string ForeignKeyTable { get; set; }
	public string ForeignKeyTableColumnName { get; set; }
}
```
