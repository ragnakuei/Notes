# 以 merge 做一次性的 CRUD

```sql
declare @tmpTable table (
	[Id] int,
	[Name] nvarchar(50),
	[ParentId] int
)

insert into @tmpTable
values(2, 'B1', 1),
      (3, 'C1', 1),
	  (6, 'G', 1)

begin tran

MERGE dbo.TestTableA t 
USING @tmpTable s
	ON  t.Id = s.Id 
	AND t.ParentId = s.ParentId
WHEN MATCHED 
	THEN UPDATE 
		SET t.Name = s.Name
WHEN NOT MATCHED BY TARGET 
    THEN INSERT (Id, Name, ParentId)
         VALUES (s.Id, s.Name, s.ParentId)
WHEN NOT MATCHED BY SOURCE AND t.ParentId = 1  -- 符合 AND 的條件，才會被刪除
    THEN DELETE;

-- rollback tran

select *
from dbo.TestTableA
```