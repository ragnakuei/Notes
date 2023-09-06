# 新增資料後，取得該筆資料的 Identity

註： 一個資料表的 Identity 欄位只能有一個 !

### 當只有一個 Identity 欄位時

```sql
INSERT INTO [dbo].[TestA]([Name])
VALUES ('A')

-- 意即取出最新的 Identity 欄位值
SELECT @@IDENTITY

-- 下面這個語法也可以 !
-- SELECT SCOPE_IDENTITY()
```
