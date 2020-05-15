# @Temp Table

建立在記憶體中

```sql
DECLARE @TmpTable TABLE
                  (
                      [FirstName] VARCHAR(20),
                      [LastName]  VARCHAR(20)
                  )

DELETE
FROM @TmpTable

DECLARE @TmpTable TABLE
                  (
                      [input] NVARCHAR(50)
                  );

INSERT INTO @TmpTable([input])
SELECT [Item]
FROM [Table1]

INSERT INTO @TmpTable
SELECT [Item]
FROM [Table1]
```