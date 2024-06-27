# # Temp Table

該 Session 關閉時會被刪除的暫存資料表。


## DROP 語法

### 方式一

```sql
IF OBJECT_ID('tempdb..#test') IS NOT NULL 
    Drop Table #test
```

### 方式二

MS SQL 2016 以後

```sql
Drop Table IF EXISTS #test
```
