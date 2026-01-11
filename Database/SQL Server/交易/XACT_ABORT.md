# XACT_ABORT

注意事項：
-   當 SET XACT_ABORT 是 ON 時，如果 Transact-SQL 陳述式產生執行階段錯誤，就會終止和回復整個交易。
-   當 SET XACT_ABORT 是 OFF 時，在某些情況下，只會回復產生錯誤的 Transact-SQL 陳述式，交易會繼續進行。
-   有可能會導致無法進入 CATCH 區塊，但目前沒有明確的範例 !

## 測試情境 1

### 修正前

假設先執行

```sql
IF OBJECT_ID('tempdb..#tableA') IS NOT NULL
    DROP TABLE [#tableA];

CREATE TABLE [#tableA]
(
    [id] INT PRIMARY KEY
);

```

再執行

```sql
SET XACT_ABORT ON;

-- 這邊沒有 BEGIN TRANSACTION

INSERT INTO [#tableA] ( [id] )
VALUES ( 1 );

-- 這段會因為重複 Key 值而執行失敗
INSERT INTO [#tableA] ( [id] )
VALUES ( 1 );
```

上述整個執行失敗後，再執行下面的語法

```sql
SELECT *
FROM [#tableA];
```

會發現資料仍然寫入了 !
所以 `SET XACT_ABORT ON` 最好搭配 TRANSACTION 一起使用，確保在錯誤發生時能夠完整回滾該次執行的交易。

### 修正後

假設先執行

```sql
IF OBJECT_ID('tempdb..#tableA') IS NOT NULL
    DROP TABLE [#tableA];

CREATE TABLE [#tableA]
(
    [id] INT PRIMARY KEY
);

```

再執行

```sql
SET XACT_ABORT ON;

-- 這邊有 BEGIN TRANSACTION
BEGIN TRANSACTION

INSERT INTO [#tableA] ( [id] )
VALUES ( 1 );

-- 這段會因為重複 Key 值而執行失敗
INSERT INTO [#tableA] ( [id] )
VALUES ( 1 );
```

上述整個執行失敗後，再執行下面的語法

```sql
SELECT *
FROM [#tableA];
```

會發現沒有寫入資料 !
所以 `SET XACT_ABORT ON` 最好搭配 TRANSACTION 一起使用，確保在錯誤發生時能夠完整回滾該次執行的交易。
