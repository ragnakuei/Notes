# XACT_ABORT

當 `SET XACT_ABORT ON` 時，如果在交易中發生任何錯誤，SQL Server 會自動回滾整個交易並終止執行。這對於確保資料一致性非常有用，但也可能導致無法進入 CATCH 區塊來進行自訂的錯誤處理。

範圍是針對該次執行的 SQL Script

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
所以 `SET XACT_ABORT ON` 最好搭配 TRANSACTION 一起使用，確保在錯誤發生時能夠完整回滾交易。

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
所以 `SET XACT_ABORT ON` 最好搭配 TRANSACTION 一起使用，確保在錯誤發生時能夠完整回滾交易。

## 測試情境 2 - 與 TRY CATCH 的搭配注意事項

使用 SET XACT_ABORT ON 時，若交易中發生錯誤，會自動回滾交易並終止執行，導致無法進入 CATCH 區塊。
沒有進入 CATCH 區塊的話，反而是由 XACT_ABORT 來處理 ROLLBACK。

```sql
-- 清掉快取以便重現
DBCC FREEPROCCACHE;
GO

SET XACT_ABORT ON;
GO

BEGIN TRY
    BEGIN TRANSACTION;

    -- 這裡模擬一個 runtime 錯誤
    SELECT 1 / 0 AS [DivideByZero];

    -- 這行理論上不會執行，因錯誤已發生
    SELECT 'SUCCESS'
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    PRINT '進入 CATCH';
    PRINT ERROR_MESSAGE();

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
END CATCH;
```
