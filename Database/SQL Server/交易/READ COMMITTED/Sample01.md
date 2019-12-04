# READ COMMITTED Sample01

先準備二段語法

## 第一段語法：A

更新資料後，等待 20 秒再取消 Transaction

```sql
BEGIN TRANSACTION Test

UPDATE Orders
SET EmployeeID = 5
WHERE OrderId = 10248

WAITFOR DELAY '00:00:20'

ROLLBACK TRANSACTION Test
```

## 第二段語法：B

```sql
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SELECT * FROM orders WHERE OrderId = 10248
```

## 不同情境執行結果

1. 當執行 A 語法後，再立即執行 B 語法，就會發現 B 語法無法立即完成，必須等到 A 語法的 20 秒完成後，才可以完成 B 語法

1. 當 B 語法的查詢條件改成 where OrderId = `10249` 時，再重複 1. 項動作，就會發現 B 語法不用等 A 語法的 20 秒完成，就可以立即執行完畢，確認是 Row-Level Lock

1. 當 A 語法的查詢條件改成以下時，也就是以查詢的方式進行 Transaction，再重複 1. 項動作，就會發現 B 語法不用等 A 語法的 20 秒完成，就可以立即執行完畢，確認只有在修改資料的情境可以產生 Lock

    ```sql
    BEGIN TRANSACTION Test

    SELECT * FROM orders WHERE OrderId = 10248

    WAITFOR DELAY '00:00:20'

    ROLLBACK TRANSACTION Test
    ```