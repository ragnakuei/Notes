
https://dotblogs.com.tw/alenwu_coding_blog/2017/06/03/sql_lock_check

https://www.dbrnd.com/2016/04/sql-server-8-different-ways-to-detect-a-deadlock-in-a-database/

https://docs.microsoft.com/zh-tw/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide?view=sql-server-2017

https://dotblogs.com.tw/karen0416/archive/2011/11/18/58623.aspx
http://terence-mak.blogspot.com/2013/10/sql-server-lock.html
http://sharedderrick.blogspot.com/2007/12/blocked-lock-connectoin.html
https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/sp-lock-transact-sql?view=sql-server-2017
https://docs.microsoft.com/en-us/sql/relational-databases/system-dynamic-management-views/sys-dm-tran-locks-transact-sql?view=sql-server-2017


```sql

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

刪除資料時，會先 select 出對應的資料
如果沒有下準索引鍵，就會導致 table scan 進而 lock 整張 table




5000

[Lock Escalation](https://docs.microsoft.com/en-us/previous-versions/sql/sql-server-2008-r2/ms184286(v=sql.105))