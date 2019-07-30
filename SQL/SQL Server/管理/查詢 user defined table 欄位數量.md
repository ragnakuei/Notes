
```sql
select *
from (
        Select t.name   [TableTypeName]
              ,SCHEMA_NAME(t.schema_id)  [SchemaName]
              ,c.name   [Column Name]
              ,y.name   [Data Type]
              ,c.max_length
              ,c.precision
              ,c.is_identity
              ,c.is_nullable
        From sys.table_types t
        Inner join sys.columns c on c.object_id = t.type_table_object_id
        Inner join sys.types y ON y.system_type_id = c.system_type_id
        WHERE t.is_user_defined = 1
          AND t.is_table_type = 1
) t
WHERE SchemaName = 'fd'
AND TableTypeName = 'ut_TestTemp'
```