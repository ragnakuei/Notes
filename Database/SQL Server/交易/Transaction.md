
設定交易層級是針對該次查詢有意義

[資料庫的交易鎖定 Locks](https://www.qa-knowhow.com/?p=383)

- https://myapollo.com.tw/2018/09/30/database-transaction-isolation-levels/

- https://ithelp.ithome.com.tw/articles/10194749?sc=p

- https://medium.com/getamis/database-transaction-isolation-a1e448a7736e

## Nested Transaction

```sql
SELECT *
FROM dbo.TestA

BEGIN TRAN A1

-- A2 交易
BEGIN TRAN A2
INSERT INTO dbo.TestA (Id)
VALUES (6)
COMMIT TRAN A2

-- A3 交易
BEGIN TRAN A3
INSERT INTO dbo.TestA (Id)
VALUES (7)
COMMIT TRAN A3

ROLLBACK TRAN A1

SELECT *
FROM dbo.TestA
```
