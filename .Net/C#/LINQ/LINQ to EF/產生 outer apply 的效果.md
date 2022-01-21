# 產生 outer apply 的效果



```cs
(
from c in Customers
from o in Orders.Where(o => o.CustomerID == c.CustomerID).OrderByDescending(o => o.OrderDate).Take(1)
select new
{
    c.CompanyName,
    o.OrderDate,
}
).OrderBy(x => x.CompanyName).Dump();
```


```sql
SELECT [t0].[CompanyName], [t2].[OrderDate]
FROM [Customers] AS [t0]
CROSS APPLY (
    SELECT TOP (1) [t1].[OrderDate]
    FROM [Orders] AS [t1]
    WHERE [t1].[CustomerID] = [t0].[CustomerID]
    ORDER BY [t1].[OrderDate] DESC
    ) AS [t2]
ORDER BY [t0].[CompanyName], [t2].[OrderDate] DESC
```