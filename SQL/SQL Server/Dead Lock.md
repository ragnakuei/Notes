
https://dotblogs.com.tw/alenwu_coding_blog/2017/06/03/sql_lock_check

https://www.dbrnd.com/2016/04/sql-server-8-different-ways-to-detect-a-deadlock-in-a-database/


```

SELECT request_session_id AS spid,
  resource_type AS rt,
  resource_databASe_id AS rdb,
  (CASE resource_type
  WHEN 'OBJECT' then object_name(resource_ASsociated_entity_id)
  WHEN 'DATABASE' then '<db_name>'
  ELSE
  (SELECT object_name(object_id) FROM sys.partitions
      WHERE hobt_id = resource_ASsociated_entity_id) END) AS objname,
  resource_description AS rd,
  request_mode AS rm,
  request_status AS rs
FROM sys.dm_tran_locks


```