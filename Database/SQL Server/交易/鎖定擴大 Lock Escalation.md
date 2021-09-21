# 鎖定擴大 Lock Escalation

SQL Server 2005 之後才有的功能

處理資料異動時，要注意處理資料筆數


```
單一SQL對資料表進行異動若一次超過5000筆(預設值)，則資料庫會啟動保護機制，將鎖定的等級進行提升。一方面是為了減少系統負擔（記憶體變少），但另一方面增加了系統blocking。
```

https://medium.com/codxfrankenstein/sql-server-%E9%8E%96%E5%AE%9A%E6%93%B4%E5%A4%A7-af9a425e4e3b

https://dotblogs.com.tw/ricochen/2012/02/17/69565

https://social.technet.microsoft.com/wiki/contents/articles/19870.sql-server-understanding-lock-escalation.aspx

