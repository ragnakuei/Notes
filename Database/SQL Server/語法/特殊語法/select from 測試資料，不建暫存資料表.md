# select from 測試資料，不建暫存資料表


```sql
SELECT [id],
       SUM([status])
FROM (
         VALUES (1, 2),
                (1, NULL),
                (1, 1)
     ) AS [TmpTable]([id], [status])
GROUP BY [id]
```