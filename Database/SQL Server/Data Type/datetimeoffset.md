# datetimeoffset

##### 將 datetime 轉成 datetimeoffset

```sql
-- 查出所在的時區 為 Taipei Standard Time
SELECT *
FROM [sys].[time_zone_info]
WHERE [current_utc_offset] LIKE '+08%'


DECLARE @table1 TABLE
                (
                    [UserId]      [int],
                    [CreatedDate] [datetime],
                    [UpdatedDate] [datetime]
                );
INSERT INTO @table1([UserId], [CreatedDate], [UpdatedDate])
VALUES (1, '2021/01/02', '2021/01/02'),
       (2, '2021/01/03', '2021/01/04'),
       (3, '2021/01/05', '2021/01/06')

DECLARE @table2 TABLE
                (
                    [UserId]      [int],
                    [CreatedDate] [datetimeoffset],
                    [UpdatedDate] [datetimeoffset]
                );

INSERT INTO @table2([UserId], [CreatedDate], [UpdatedDate])
SELECT [UserId],
       [CreatedDate] AT TIME ZONE 'Taipei Standard Time',
       [UpdatedDate] AT TIME ZONE 'Taipei Standard Time'
FROM @table1

SELECT *
FROM @table2
```
