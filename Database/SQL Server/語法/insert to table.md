# insert to table

## 方式一

```sql
INSERT INTO [dbo].[Test]([Id], [Name])
VALUES (@Id, @Name)
```

## 方式二

```sql
INSERT INTO [dbo].[Test]([Id], [Name])
SELECT [Id],
       @Name
FROM [dbo].[Test2]
WHERE [Id] = @Id
```
