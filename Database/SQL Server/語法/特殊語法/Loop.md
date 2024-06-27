# Loop

## Cursor

```sql
DECLARE @index varchar(2)
DECLARE [@index_cursor] CURSOR FOR
    SELECT [index]
    FROM (
        VALUES (0),
               (1),
               (2)
    ) AS [T]([index])


OPEN [@index_cursor]
FETCH NEXT FROM [@index_cursor] INTO @index
WHILE @@FETCH_STATUS = 0
    BEGIN

        PRINT 'index:' + @index

        FETCH NEXT FROM [@index_cursor] INTO @index
    END
CLOSE [@index_cursor]
DEALLOCATE [@index_cursor]
```


## While + ROWCOUNT

語法上比 Cursor 簡單

```sql
DECLARE @table table
               (
                   [id] int
               )

INSERT INTO @table
VALUES (1),
       (2),
       (3)

DECLARE @cnt int
SELECT @cnt = COUNT(*)
FROM @table

DECLARE @currentId int = -1

WHILE @cnt > 0
    BEGIN

        SELECT * FROM @table

        -- 設定只影響一筆資料
        SET ROWCOUNT 1

        SELECT @currentId = [id] FROM @table
        SET @cnt = @cnt - 1

        DELETE @table

        -- 回復設定
        SET ROWCOUNT 0

        PRINT @currentId
    END
```

