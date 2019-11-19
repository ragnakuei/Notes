# [Table Variable]()

[加快資料表變數](https://docs.microsoft.com/en-us/sql/relational-databases/in-memory-oltp/faster-temp-table-and-table-variable-by-using-memory-optimization#d-scenario-table-variable-can-be-memory_optimizedon)

## 前置動作

如果沒有對應的設定就會出現以下的錯誤
> 無法建立 記憶體最佳化資料表。若要建立 記憶體最佳化資料表，資料庫的 MEMORY_OPTIMIZED_FILEGROUP 必須在線上，而且至少須包含一個容器。

## 建立方式

在宣告資料表類型時加上

```sql
WITH  (MEMORY_OPTIMIZED = ON);
```

就可以了

完成語法如下：

```sql
CREATE TYPE dbo.typeTableD  
    AS TABLE  
    (  
        Column1  INT   NOT NULL   INDEX ix1,  
        Column2  CHAR(10)  
    )  
    WITH  
        (MEMORY_OPTIMIZED = ON);
```
