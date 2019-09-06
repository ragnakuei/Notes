# Stored Procedure 的錯誤處理

當在 SP 中使用 Transaction 時，如果要正確回應 Error 有以下二種方式：

```sql
CREATE PROCEDURE fd.usp_OM_Department_ReportCenterGetOrgChangeDoc ()
AS
BEGIN
    BEGIN TRY
        RAISERROR ('Error raised in TRY block.', -- Message text.  
        16, -- Severity.  
        1 -- State.  
                );  
    END TRY
    BEGIN CATCH
        -- 方式一
        --return ERROR_MESSAGE();

        -- 方式二
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

         SELECT
            @ErrorMessage=ERROR_MESSAGE(),
            @ErrorSeverity=ERROR_SEVERITY(),
            @ErrorState=ERROR_STATE();
 
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);

    END CATCH
END
```
