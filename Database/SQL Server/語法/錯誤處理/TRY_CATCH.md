# TRY CATCH

```sql
BEGIN TRY
    Create Table ##LookBooksExpandLookBookBlock (
        [LbbID] [int] NOT NULL
    )
END TRY

BEGIN CATCH
    DROP Table ##LookBooksExpandLookBookBlock
END CATCH
```
