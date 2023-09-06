# FOR XML PATH

以 , 分隔，同時會以 , 結尾

```sql
SELECT [o].*,
       (SELECT CAST([od].[ProductID] AS VARCHAR(10)) + ','
        FROM [Order Details] [od]
        WHERE [od].[OrderID] = [o].[OrderID]
        FOR XML PATH('')
       ) AS [ProductIDs]
FROM [Orders] [o]
```

以 , 分隔，不會以 , 結尾

- 以 , 欄位 來串接
- 再以 STUFF 來消除第一個 ,

```sql
SELECT [o].*,
       STUFF((SELECT ',' + CAST([od].[ProductID] AS VARCHAR(10))
              FROM [Order Details] [od]
              WHERE [od].[OrderID] = [o].[OrderID]
              FOR XML PATH('')
             ), 1, 1, '') AS [ProductIDs]
FROM [Orders] [o]
```
