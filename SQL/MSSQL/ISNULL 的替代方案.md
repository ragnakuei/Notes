# ISNULL 的替代方案

因為 ISNULL 只有二個引數，就是只能針對單一情境做判斷

[Coalesce v.s. ISNULL](https://dotblogs.com.tw/rynote/2019/05/14/154425)

如果需要多情境時，可以改用 coalesce

```sql
select coalesce(null, 0) as column1
select coalesce(null, 1, 0) as column1
select coalesce(null, null, 1, 0) as column1
```

當第一個引數是 null 時，就會判斷第二個引數，

