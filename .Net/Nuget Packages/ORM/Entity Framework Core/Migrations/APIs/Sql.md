# Sql

執行 sql

- suppressTransaction - true 是指不需要 Transaction

## 範例

```csharp
migrationBuilder.Sql(sql: @"
UPDATE [dbo].[TableA]
SET [ColumnA] = NULL,
    [ColumnB] = NULL
",
                     suppressTransaction: false);
```
