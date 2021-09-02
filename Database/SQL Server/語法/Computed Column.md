# Computed Column

-   用來儲存針對某欄位的計算後的結果\
-   可建立 non-cluster index

## 建立方式

下面欄位 **NameSub35** 就是 Computed Column

-   PERSISTED 可自行決定是否要加

```sql
CREATE TABLE [dbo].[TestTableA](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[NameSub35]  AS (substring([Name],(3),(5))) PERSISTED,
 CONSTRAINT [PK_TestTableA] PRIMARY KEY CLUSTERED
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
```

```sql
ALTER TABLE [dbo].[TestTableA]
    ADD [NameSub35] AS SUBSTRING([Name], 3, 5) PERSISTED
```

## performance

-   [Computed Column Performance in SQL Server](https://www.red-gate.com/simple-talk/databases/sql-server/performance-sql-server/computed-column-performance-in-sql-server/)
