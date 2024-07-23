#

```sql
SELECT HASHBYTES('SHA2_256',  '要 hash 的字串') AS [二進位] ,
       CONVERT(VARCHAR(64), HASHBYTES('SHA2_256',  '要 hash 的字串'), 2) AS [十六進位]
```
