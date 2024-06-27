
```sql
DECLARE @sales Table
               (
                   [id]      INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
                   [Product] varchar(50),
                   [Amount]  int,
                   [Year]    int
               )
INSERT INTO @sales([Product], [Amount], [Year])
VALUES            ('A',       100,      2019  ),
                  ('A',       200,      2020  ),
                  ('B',       300,      2019  ),
                  ('B',       400,      2020  ),
                  ('C',       500,      2019  ),
                  ('C',       600,      2020  ),
                  ('D',       700,      2019  ),
                  ('D',       800,      2020  )

-- FOR 是指橫向展開的欄位，也是原先資料的值
-- SUM() 是指會放到新的欄位中的值，如果該欄位的資料型態是非數字的，可以用 MIN、MAX 
-- 除了上述的二個欄位，再加上一個關聯用的欄位，其餘的欄位不可以被 Select 出來，會失去 PIVOT 的效果

SELECT *
FROM (
         SELECT [Product], [Amount], [Year]
         FROM @sales
     ) AS [SourceTable]
    PIVOT
    (
        SUM([Amount])
        FOR [Year] IN ([2019], [2020])
    ) AS [PivotTable];
```