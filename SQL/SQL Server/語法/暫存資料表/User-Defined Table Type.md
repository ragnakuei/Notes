# User-Defined Table Type

```sql
IF TYPE_ID('dbo.ut_TestTableType') IS NOT NULL
    DROP TYPE dbo.ut_TestTableType
GO

CREATE TYPE dbo.ut_TestTableType AS TABLE
(
    Id int not null  PRIMARY KEY,
    Name nvarchar(50),
    Type int INDEX ix_Type NONCLUSTERED,
    INDEX ix_Id NONCLUSTERED (Name DESC)  
)
GO
```

## 不允許有自定義的 naming of contraints

[Test](https://stackoverflow.com/questions/4451052/how-to-add-an-index-or-primary-key-to-a-user-defined-table-type-in-sql-server)
