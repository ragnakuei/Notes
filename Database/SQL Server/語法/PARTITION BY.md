# PARTITION BY

### 範例

```sql

SELECT [summary].*,
       [summary].[score] - [summary].[AverageScore] AS [DifferenceScore]
FROM (
    SELECT [course].[name]                                                            AS [CourseName],
           [student].[name]                                                           AS [StudentName],
           [score],
           ROW_NUMBER() OVER (PARTITION BY [grades].[courseId] ORDER BY [score] DESC) AS [Rank],
           COUNT([score]) OVER ( PARTITION BY [grades].[courseId])                    AS [StudentCount],
           AVG([score]) OVER ( PARTITION BY [grades].[courseId])                      AS [AverageScore],
           MIN([score]) OVER ( PARTITION BY [grades].[courseId])                      AS [MinScore],
           MAX([score]) OVER ( PARTITION BY [grades].[courseId])                      AS [MaxScore]
    FROM (VALUES (1, 1, 63),
                 (1, 2, 70),
                 (1, 3, 80),
                 (1, 4, 40),
                 (1, 6, 79),
                 (1, 7, 99),
                 (2, 1, 65),
                 (2, 2, 77),
                 (2, 3, 85),
                 (2, 5, 95),
                 (3, 1, 55),
                 (3, 2, 68),
                 (3, 3, 75),
                 (3, 4, 85),
                 (3, 5, 95)
         ) [grades]([courseId], [studentId], [score])
        LEFT JOIN (VALUES (1, N'國文'),
                          (2, N'英文'),
                          (3, N'數學')
                  ) [course]([courseId], [name])
                  ON [grades].[courseId] = [course].[courseId]
        LEFT JOIN (VALUES (1, N'張三'),
                          (2, N'李四'),
                          (3, N'王五'),
                          (4, N'赵六'),
                          (5, N'陳七'),
                          (6, N'黃八'),
                          (7, N'魏九')
                  ) [student]([studentId], [name])
                  ON [grades].[studentId] = [student].[studentId]
     ) [summary]
```