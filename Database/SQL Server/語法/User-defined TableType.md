# User-defined TableType

```sql
IF type_id('[dbo].[tIdName]') IS NOT NULL
        DROP TYPE [dbo].[tIdName];

CREATE TYPE [dbo].[tIdName] AS TABLE
    (
        [Id] int,
        [Name] nvarchar(10)
    );
```