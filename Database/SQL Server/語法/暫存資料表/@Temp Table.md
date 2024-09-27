# @Temp Table

建立在記憶體中

```sql
DECLARE @TmpTable TABLE
                  (
                      [FirstName] VARCHAR(20),
                      [LastName]  VARCHAR(20),
                      [Sex]       INT,
                      [FullName]  AS [FirstName] + ' ' + [LastName],
                      [Sexname]   AS IIF([Sex] = 1, 'Man', 'Woman')
                  )

INSERT INTO @TmpTable ([FirstName], [LastName], [Sex])
VALUES ('John', 'Doe', 1)

SELECT *
FROM @TmpTable


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