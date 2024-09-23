# OUTER APPLY

## 群組化欄位後，取各群組排序第一的資料

-   有 LEFT JOIN 的效果

```sql
; WITH [TestA] AS (
                    SELECT *
                    FROM (
                             VALUES (1, 'A'),
                                    (2, 'B'),
                                    (3, 'C')
                         ) AS [TestA] ([ID], [Name])
                ),
     [TestB] AS (
                    SELECT *
                    FROM (
                             VALUES (1, 'C01'),
                                    (1, 'C02'),
                                    (1, 'C03'),
                                    (2, 'C01'),
                                    (2, 'C02'),
                                    (3, 'C01')
                         ) AS [TestB] ([ID], [CourseID])
                )
SELECT *
FROM [TestA]
OUTER APPLY (
                SELECT TOP 1 *
                FROM [TestB]
                WHERE [TestB].[ID] = [TestA].[ID]
            ) AS [TestB]
```
