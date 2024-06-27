## 參考資料

- [一些抓取資料庫結構及述敍用的 SQL](https://blog.uwinfo.com.tw/auth/article/bike/329)

## 資料表

### 查詢

```sql
SELECT [ep].[value] AS [TableDescription]
FROM [sys].[tables]                    AS [t]
INNER JOIN [sys].[extended_properties] AS [ep]
           ON [t].[object_id] = [ep].[major_id]
WHERE [ep].[class] = 1
  AND [ep].[minor_id] = 0 -- 表示這是針對整個資料表的屬性，而不是針對欄位的
  AND [ep].[name] = 'MS_Description'
  AND [t].[name] = 'User';
```

### 更新或建立

```cs
var sqlParameters = new DynamicParameters();
sqlParameters.Add("@TABLE_SCHEMA", tableDto.TABLE_SCHEMA);
sqlParameters.Add("@TABLE_NAME",   tableDto.TABLE_NAME);
sqlParameters.Add("@CName",        tableDto.CName);
sqlParameters.Add("@Description",  tableDto.Description);
```


```sql
-- MS_CName
IF NOT EXISTS
(
    SELECT 1
    FROM [sys].[extended_properties]
    WHERE [major_id] = OBJECT_ID(@TABLE_SCHEMA + '.' + @TABLE_NAME)
      AND [minor_id] = 0
      AND [name] = 'MS_CName'
)
    BEGIN
        EXEC [sys].[sp_addextendedproperty] @name = N'MS_CName',
             @value = @CName,
             @level0type = N'SCHEMA',
             @level0name = @TABLE_SCHEMA,
             @level1type = N'TABLE',
             @level1name = @TABLE_NAME;
    END
ELSE
    BEGIN
        EXEC [sys].[sp_updateextendedproperty] @name = N'MS_CName',
             @value = @CName,
             @level0type = N'SCHEMA',
             @level0name = @TABLE_SCHEMA,
             @level1type = N'TABLE',
             @level1name = @TABLE_NAME;
    END

-- MS_Description
IF NOT EXISTS
(
    SELECT 1
    FROM [sys].[extended_properties]
    WHERE [major_id] = OBJECT_ID(@TABLE_SCHEMA + '.' + @TABLE_NAME)
      AND [minor_id] = 0
      AND [name] = 'MS_Description'
)
    BEGIN
        EXEC [sys].[sp_addextendedproperty] @name = N'MS_Description',
             @value = @Description,
             @level0type = N'SCHEMA',
             @level0name = @TABLE_SCHEMA,
             @level1type = N'TABLE',
             @level1name = @TABLE_NAME;
    END
ELSE
    BEGIN
        EXEC [sys].[sp_updateextendedproperty] @name = N'MS_Description',
             @value = @Description,
             @level0type = N'SCHEMA',
             @level0name = N'dbo',
             @level1type = N'TABLE',
             @level1name = @TABLE_NAME;
    END

```

### 欄位

```sql
-- 查出指定資料表欄位的 MS_Description
SELECT [t].[name]    [Table],
       [c].[name]    [Column],
       [sep].[value] [Description]
FROM [sys].[tables]                    [t]
INNER JOIN [sys].[columns]             [c]
           ON [t].[object_id] = [c].[object_id]
LEFT JOIN  [sys].[extended_properties] [sep]
           ON [t].[object_id] = [sep].[major_id]
               AND [c].[column_id] = [sep].[minor_id]
               AND [sep].[name] = 'MS_Description'
WHERE [t].[name] = 'TestTable'
```


### 更新或建立

```cs
sqlParameters = new DynamicParameters();
sqlParameters.Add("@TABLE_SCHEMA", tableDto.TABLE_SCHEMA);
sqlParameters.Add("@TABLE_NAME",   tableDto.TABLE_NAME);
sqlParameters.Add("@COLUMN_NAME",  column.COLUMN_NAME);
sqlParameters.Add("@PropertyName", kv.Key);
var propertyValue = kv.Value.Invoke(column) ?? "";
sqlParameters.Add("@PropertyValue", propertyValue);
```


```sql
IF NOT EXISTS
(

    SELECT 1
    FROM [sys].[extended_properties] [EP]
    JOIN [sys].[all_objects]         [O]
         ON [EP].[major_id] = [O].[object_id]
             AND [O].[name] = @TABLE_NAME
    JOIN [sys].[schemas]             [S]
         ON [O].[schema_id] = [S].[schema_id]
             AND [S].[name] = @TABLE_SCHEMA
    JOIN [sys].[columns] AS          [C]
         ON [EP].[major_id] = [C].[object_id]
             AND [EP].[minor_id] = [C].[column_id]
             AND [C].[name] = @COLUMN_NAME
    WHERE [EP].[name] = @PropertyName
)
    BEGIN
        EXEC [sys].[sp_addextendedproperty] @name = @PropertyName,
             @value = @PropertyValue,
             @level0type = N'SCHEMA',
             @level0name = @TABLE_SCHEMA,
             @level1type = N'TABLE',
             @level1name = @TABLE_NAME,
             @level2type = N'COLUMN',
             @level2name = @COLUMN_NAME;
    END
ELSE
    BEGIN
        EXEC [sys].[sp_updateextendedproperty] @name = @PropertyName,
             @value = @PropertyValue,
             @level0type = N'SCHEMA',
             @level0name = @TABLE_SCHEMA,
             @level1type = N'TABLE',
             @level1name = @TABLE_NAME,
             @level2type = N'COLUMN',
             @level2name = @COLUMN_NAME;
    END

```






