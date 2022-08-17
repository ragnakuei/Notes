# RollUp & GROUPING

## 小計、合計



```sql
-- 表結構
DECLARE @student TABLE
                 (
                     [ID]          [int]            NOT NULL,
                     [StudentName] [nvarchar](50)   NULL,
                     [Sex]         [int]            NOT NULL,
                     [GradeName]   [nvarchar](50)   NULL,
                     [ClassName]   [nvarchar](50)   NULL,
                     [BodyWeight]  [decimal](18, 2) NOT NULL,
                     [Area]        [nvarchar](50)   NULL
                 )

INSERT INTO @student ([ID], [StudentName], [Sex], [GradeName], [ClassName], [BodyWeight], [Area])
VALUES (1, N'張三', 1, N'高一', N'1班', CAST(140.00 AS DECIMAL(18, 2)), N'中國'),
       (2, N'李四', 1, N'高一', N'1班', CAST(140.00 AS DECIMAL(18, 2)), N'中國'),
       (3, N'王五', 1, N'高一', N'1班', CAST(155.00 AS DECIMAL(18, 2)), N'中國'),
       (4, N'奧巴馬', 1, N'高一', N'2班', CAST(138.00 AS DECIMAL(18, 2)), N'美國'),
       (5, N'希拉里', 0, N'高一', N'2班', CAST(113.00 AS DECIMAL(18, 2)), N'美國'),
       (6, N'習XX', 1, N'高一', N'1班', CAST(110.00 AS DECIMAL(18, 2)), N'中國'),
       (7, N'溫寶寶', 1, N'高一', N'1班', CAST(200.00 AS DECIMAL(18, 2)), N'中國'),
       (8, N'埃希', 0, N'高一', N'1班', CAST(123.00 AS DECIMAL(18, 2)), N'澳大利亞'),
       (9, N'卡特琳娜', 0, N'高二', N'1班', CAST(145.00 AS DECIMAL(18, 2)), N'澳大利亞'),
       (10, N'德瑪西亞', 1, N'高二', N'2班', CAST(90.00 AS DECIMAL(18, 2)), N'英國'),
       (11, N'嘉文', 1, N'高二', N'2班', CAST(95.00 AS DECIMAL(18, 2)), N'英國'),
       (12, N'德邦', 1, N'高二', N'2班', CAST(102.00 AS DECIMAL(18, 2)), N'英國'),
       (13, N'蠻子', 1, N'高三', N'1班', CAST(160.00 AS DECIMAL(18, 2)), N'剛果'),
       (14, N'易大師', 1, N'高三', N'1班', CAST(120.00 AS DECIMAL(18, 2)), N'剛果')

-- SELECT *
-- FROM @student;

-- 只有 合計
SELECT CASE WHEN GROUPING([GradeName]) = 1 THEN N'合計' ELSE [GradeName] END AS [年級],
       [ClassName]                                                           AS [班級],
       SUM(CASE WHEN [Sex] = 1 THEN 1 ELSE 0 END)                            AS [男生數],
       SUM(CASE WHEN [Sex] = 0 THEN 1 ELSE 0 END)                            AS [女生數],
       COUNT([Sex])                                                          AS [總數]
FROM @student
GROUP BY [GradeName],
         [ClassName]
WITH ROLLUP
HAVING GROUPING([GradeName]) = 1
    OR GROUPING([ClassName]) = 0
ORDER BY [GradeName] DESC

-- 有 合計 & 小計
SELECT CASE
           WHEN GROUPING([GradeName]) = 1 THEN N'合計'
           WHEN GROUPING([ClassName]) = 1 THEN N'小計'
           ELSE [GradeName] END                   AS [年級],
       [ClassName]                                AS [班級],
       SUM(CASE WHEN [Sex] = 1 THEN 1 ELSE 0 END) AS [男生數],
       SUM(CASE WHEN [Sex] = 0 THEN 1 ELSE 0 END) AS [女生數],
       COUNT([Sex])                               AS [總數]
FROM @student
GROUP BY [GradeName],
         [ClassName]
WITH ROLLUP
ORDER BY [GradeName] DESC,
         GROUPING([GradeName]),
         GROUPING([ClassName])
```