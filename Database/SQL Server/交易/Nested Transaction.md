# Nested Transaction

SQL Server 不支援巢狀交易 (Nested Transaction)，當在一個交易內部啟動另一個交易時，內部交易只是增加了交易的計數器，並不會真正開始一個新的獨立交易。只有最外層的交易提交或回滾才會影響到資料庫的狀態。

## 錯誤處理方式

使用 **TRY-CATCH 搭配手動 ROLLBACK** 的方式，而不使用 `SET XACT_ABORT ON`，原因如下：

- `SET XACT_ABORT ON` 會在錯誤發生時自動回滾交易並**立即終止執行**，導致無法進入 CATCH 區塊
- 使用 TRY-CATCH 可以：
  - 捕捉錯誤並記錄日誌
  - 執行自訂的錯誤處理邏輯
  - 決定是否要重新拋出錯誤（THROW）
- 在 CATCH 區塊中檢查 `@@TRANCOUNT > 0` 再執行 `ROLLBACK`，確保交易正確回滾

## 通用 SP 的錯誤處理模式

當 SP 需要被各種情境呼叫，且需要記錄錯誤日誌時，應該：

1. **不主動管理交易邊界**（讓呼叫者決定）
2. **捕捉錯誤並記錄日誌**
3. **重新拋出錯誤**（讓呼叫者知道發生問題）

### SP 範例（被呼叫端）

```sql
CREATE PROCEDURE [dbo].[sp_UpdateUserData]
    @userId INT,
    @userName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- 不要在這裡 BEGIN TRANSACTION
        -- 只做資料操作
        UPDATE Users 
        SET UserName = @userName,
            UpdatedAt = GETDATE()
        WHERE UserId = @userId;
        
        IF @@ROWCOUNT = 0
            THROW 50001, 'User not found', 1;
            
    END TRY
    BEGIN CATCH
        -- 記錄錯誤日誌
        DECLARE @errorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @errorSeverity INT = ERROR_SEVERITY();
        
        EXEC [dbo].[sp_InsertLog]
             @empno = 'system',
             @function = 'sp_UpdateUserData',
             @operation = CONCAT('UserId: ', @userId, ', Error: ', @errorMessage),
             @logdate = GETDATE();
        
        -- 重新拋出錯誤，讓呼叫者處理
        THROW;
    END CATCH
END
GO
```

### 呼叫者範例（管理交易）

```sql
DECLARE @operation NVARCHAR(50) = '';
DECLARE @now DATETIME2 = GETDATE();

BEGIN TRY
    BEGIN TRANSACTION
    
        -- 呼叫多個 SP，它們都在同一個交易中
        EXEC [dbo].[sp_UpdateUserData] 
             @userId = 1, 
             @userName = 'John Doe';
        
        EXEC [dbo].[sp_UpdateRelatedData] 
             @userId = 1, 
             @data = 'something';
        
    COMMIT TRANSACTION
    
END TRY
BEGIN CATCH
    -- 呼叫者負責交易回滾
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    
    SET @operation = 'UpdateUser Process';
    
    -- 呼叫者也可以記錄日誌（流程層級）
    EXEC [dbo].[sp_InsertLog]
         @empno = 'system',
         @function = '更新使用者資料流程',
         @operation = @operation,
         @logdate = @now;
    
    -- 決定是否要再拋出或自行處理
    THROW;
END CATCH
```

### 調整後的巢狀範例（模擬 SP 呼叫）

```sql
DECLARE @operation NVARCHAR(50) = '';
DECLARE @now DATETIME2 = GETDATE();

-- 外層：模擬主要流程
BEGIN TRY
    BEGIN TRANSACTION
    
        PRINT 'Main Process Started'
        
        -- 內層：模擬呼叫通用 SP
        BEGIN TRY
            PRINT 'Calling SP: sp_UpdateUserData'
            
            -- 模擬 SP 內部的錯誤（不在 SP 內管理交易）
            DECLARE @v2 VARCHAR = 'a';
            DECLARE @i2 INT = @v2;
            
        END TRY
        BEGIN CATCH
            -- SP 內部記錄錯誤
            SET @operation = 'sp_UpdateUserData';
            EXEC [dbo].[sp_InsertLog]
                 @empno = 'system',
                 @function = 'sp_UpdateUserData',
                 @operation = @operation,
                 @logdate = @now;
            
            -- 重新拋出給呼叫者
            THROW;
        END CATCH
        
        PRINT 'Main Process Continue'
        
    COMMIT TRANSACTION
    
END TRY
BEGIN CATCH
    -- 呼叫者處理交易回滾
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    
    SET @operation = 'Main Process';
    
    -- 流程層級的日誌
    EXEC [dbo].[sp_InsertLog]
         @empno = 'system',
         @function = '主要業務流程',
         @operation = @operation,
         @logdate = @now;
    
    -- 可選：重新拋出或處理
    -- THROW;
    PRINT 'Process Failed and Rolled Back'
    
END CATCH
```

Output：

```log
Main Process Started
Calling SP: sp_UpdateUserData
Process Failed and Rolled Back
```

### 關鍵原則

| 層級 | 責任 |
|------|------|
| **通用 SP** | ❌ 不管理交易<br>✅ 捕捉錯誤並記錄<br>✅ 重新拋出錯誤 |
| **呼叫者** | ✅ 管理交易邊界<br>✅ 決定 COMMIT/ROLLBACK<br>✅ 記錄流程層級日誌 |

這樣的設計讓 SP 可以：
- 在有交易的情境中被呼叫（參與外部交易）
- 在沒有交易的情境中被呼叫（單獨執行）
- 總是記錄錯誤日誌
- 不影響呼叫者的交易管理
