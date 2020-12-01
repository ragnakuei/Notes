# 以 merge 做一次性的 CRUD

## 語法

```sql
MERGE [放進 db 上指定的資料表] [t]
USING [來源資料] [s]
ON [t].[欄位1] = [s].[欄位2]
    AND [t].[欄位2] = [s].[欄位2]

-- 符合上面 USING 的條件
WHEN MATCHED
    THEN
    UPDATE
    SET [t].[欄位3] = [s].[欄位3],
        [t].[欄位4] = [s].[欄位4]

-- 不符合上面 USING 的條件，且資料不在 t 中
WHEN NOT MATCHED BY TARGET
    THEN
    INSERT ([欄位1], [欄位2], [欄位3])
    VALUES ([s].[欄位1], [s].[欄位2], [s].[欄位3])

-- 不符合上面 USING 的條件，且資料不在 s 中
WHEN NOT MATCHED BY SOURCE AND [t].[欄位3] = 1 
                           -- 符合 AND 的條件，才會被刪除
    THEN DELETE;
```

### 範例

```sql
CREATE TABLE [dbo].[TestTableA]
(
    [Id]       [int]          NOT NULL,
    [Name]     [nvarchar](50) NOT NULL,
    [ParentId] [nchar](10)    NOT NULL,
    CONSTRAINT [PK_TestTableA] PRIMARY KEY CLUSTERED
        (
         [Id] ASC
            ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO [dbo].[TestTableA]
VALUES (1, 'A', 1),
       (2, 'B', 1),
       (3, 'C', 1),
       (4, 'D', 1),
       (5, 'E', 1)

---------------------------------------------------------

DECLARE @tmpTable TABLE
                  (
                      [Id]       INT,
                      [Name]     NVARCHAR(50),
                      [ParentId] INT
                  )

INSERT INTO @tmpTable
VALUES (2, 'B1', 1),
       (3, 'C1', 1),
       (6, 'G', 1)

BEGIN TRAN
    MERGE [dbo].[TestTableA] [t]
    USING @tmpTable [s]
    ON [t].[Id] = [s].[Id]
        AND [t].[ParentId] = [s].[ParentId]
    WHEN MATCHED
        THEN
        UPDATE
        SET [t].[Name] = [s].[Name]
    WHEN NOT MATCHED BY TARGET
        THEN
        INSERT ([Id], [Name], [ParentId])
        VALUES ([s].[Id], [s].[Name], [s].[ParentId])
    WHEN NOT MATCHED BY SOURCE AND [t].[ParentId] = 1 -- 符合 AND 的條件，才會被刪除
        THEN DELETE;

    SELECT *
    FROM [dbo].[TestTableA]
ROLLBACK TRAN
```