# 以 Where 做到 Dynamic + 條件欄位查詢

```sql
DECLARE @tmp table
             (
                 Id   int,
                 Name nvarchar(50),
                 Age  int
             )

INSERT INTO @tmp(Id, Name, Age)
VALUES (1, 'A', 11),
       (2, 'B', 12),
       (3, 'C', 13),
       (4, 'E', 14),
       (5, 'F', 15),
       (6, 'G', 16),
       (7, 'H', 17),
       (8, 'I', 18),
       (9, 'J', 19),
       (10, 'K', 20)

-----------------------------------------------------

DECLARE @queryId int = 1
DECLARE @nameKeyword nvarchar(50) = NULL
DECLARE @queryAge int = 11

SELECT t.Id, t.Name, t.Age
FROM @tmp t
WHERE ((@queryId IS NOT NULL AND t.Id = @queryId)
       OR @queryId IS NULL)
  AND ((@nameKeyword IS NOT NULL AND t.Name LIKE @nameKeyword)
       OR @nameKeyword IS NULL)
  AND ((@queryAge IS NOT NULL AND t.Age = @queryAge)
       OR @queryAge IS NULL)
```

結構說明
> 每個條件查詢欄位，分成二段來看
> - 判斷不等於 null AND 給定欄位的條件
> - 判斷等於 NULL

缺點
> 日後維護相對費工
