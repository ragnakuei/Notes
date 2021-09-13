# 大量讀值&寫值 Lock

資料表

```sql
CREATE TABLE [dbo].[User](
	[Id] [int] NOT NULL,
	[Money] [bigint] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
```

測試語法

```sql
DECLARE @currentMoney BIGINT;

SELECT @currentMoney = [Money]
FROM [dbo].[User]
WITH (UPDLOCK)
WHERE [Id] = @id

SET @currentMoney = @currentMoney - @Money;

UPDATE [dbo].[User]
SET [Money] = @currentMoney
WHERE [Id] = @Id
```