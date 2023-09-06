# STRING_SPLIT

- SQL Server 2016 以上才支援


### 範例 01

```sql
DECLARE @XX TABLE
            (
                [X1] NVARCHAR(50) NULL,
                [X2] NVARCHAR(50) NULL
            );

INSERT INTO @XX ([X1], [X2])
VALUES (N'A', 'X200-35-02,R205-10-65'),
       (N'B', 'X203-35-02'),
       (N'C', 'X405-45-02,L210-11-07,R305-97-15'),
       (N'D', 'X200-35-02'),
       (N'E', 'R205-10-69'),
       (N'F', '');

SELECT [X1],
       [X2],
       [value]
FROM (SELECT [X1],
             [X2],
             [value] AS [s1]
      FROM @XX
          CROSS APPLY STRING_SPLIT([X2], ',')
     ) AS [query]
    CROSS APPLY STRING_SPLIT([query].[s1], '-')
```