# PIVOT 範例一



## 資料表資料

```sql
INSERT INTO [dbo].[OrderDetailSummary] ([Id],
                                        [ProductId],
                                        [OrderDate],
                                        [TotalPrice],
                                        [Count])
VALUES (1, 1, N'2010-01-01', 200, 2),
       (2, 1, N'2012-01-01', 100, 1),
       (3, 2, N'2010-01-01', 180, 3),
       (4, 2, N'2012-01-01', 120, 2),
       (5, 3, N'2010-01-01', 420, 6),
       (6, 3, N'2012-01-01', 140, 2),
       (7, 4, N'2010-01-01', 320, 4),
       (8, 4, N'2011-01-01', 160, 2),
       (9, 4, N'2012-01-01', 240, 3)
```

## 預期結果

| 年度 | 販售次數最高 ProductId | 銷售金額最高 ProductId |
| ---- | ---------------------- | ---------------------- |
|      |                        |                        |

### 販售次數最高

```sql
SELECT [Year],
       [Id],
       [ProductId],
       [Count]
FROM (
         SELECT [Year],
                [Id],
                [ProductId],
                [Count],
                ROW_NUMBER() OVER (PARTITION BY [Year] ORDER BY [Count] DESC) AS [CountRowNo]
         FROM (
                  SELECT *,
                         YEAR([OrderDate]) AS [Year]
                  FROM [dbo].[OrderDetailSummary]
              ) [odsWithYear]
     ) [odsWithYearWithCountRowNo]
WHERE [odsWithYearWithCountRowNo].[CountRowNo] = 1

```

### 銷售金額最高

```sql

```



