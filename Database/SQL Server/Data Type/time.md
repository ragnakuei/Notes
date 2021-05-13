# time

## 與 DATE 相加的方式

```sql
DECLARE @d DATE = '2019/1/3'
DECLARE @t TIME = '12:23:31'

SELECT CAST(@d AS DATETIME) + CAST(@t AS DATETIME)
```