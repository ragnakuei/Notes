# DateTime

### 取得 TimeStamp 的方式


```cs
var now = DateTime.UtcNow;

// .Net Framework 4.6 之後
var t1 = ((DateTimeOffset)now).ToUnixTimeMilliseconds().ToString();
t1.Dump();

// 自制版
var t2 = (now - new DateTime(1970, 1,1)).TotalMilliseconds.ToString().Split('.')[0];
t2.Dump();

(t1 == t2).Dump();
```