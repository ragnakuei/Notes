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

### 運算相關

#### 二個時間的相差分鐘數

```cs
var d1 = DateTime.Parse("01:02:03.2");
var d2 = DateTime.Parse("01:03:13.1");

// 方式一
(d2 -d1).TotalMinutes.Dump();

// 方式二
(Convert.ToDouble((d2.Ticks - d1.Ticks)) / TimeSpan.TicksPerMinute).Dump();
```

#### [二個時間 去掉秒數以下後 的相差分鐘數](https://github.com/ragnakuei/TrimDateTimeSeconds)

```cs
var d1 = DateTime.Parse("01:02:03.2");
var d2 = DateTime.Parse("01:03:13.1");

var d1InMinutes = (d1.Ticks / TimeSpan.TicksPerMinute).Dump();
var d2InMinutes = (d2.Ticks / TimeSpan.TicksPerMinute).Dump();
var result = d2InMinutes - d1InMinutes;
result.Dump();
```


