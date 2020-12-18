# [COALESCE](https://docs.microsoft.com/en-us/sql/t-sql/language-elements/coalesce-transact-sql)

跟 `IIF()` 極為類似

第一個引數為
- NULL - 就回傳第二個參數
- 不是 NULL - 就回傳第三個參數

```SQL
SELECT COALESCE(NULL, 0, 1)
SELECT COALESCE(1, 0, 1)
```
