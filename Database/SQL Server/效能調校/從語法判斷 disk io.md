# 從語法判斷 disk io

查出 disk read io
- 不會實際備份所有資料

```sql
BACKUP DATABASE [Northwind] TO DISK ='NUL' WITH COPY_ONLY
```

- 同時 read & write io
 - 會實際寫入
 - 
```sql
BACKUP DATABASE [Northwind] TO DISK ='C:\Temp\Test.bak' WITH COPY_ONLY
```

可以用 read & write io - read io => 大約等於 寫 的速度

 - 一頁 = 8K

```sql
PRINT 頁數 * 8 / 1024 / ( read & write io - read io ) => 寫的 MB/s
```


