# ConcurrentDictionary

- Thread Safe Dictionary
- Dictionary Value 的部份，建議都改用 Thread Safe ，否則可能會有極低(不到 1%)的風險發生搶資源的情況，造成 Debug 相當困難 !

#### GetOrAdd

```cs
var cd = new ConcurrentDictionary<string, ConcurrentBag<string>>();

var list = cd.GetOrAdd("key", new ConcurrentBag<string>());
var list = cd.GetOrAdd("key", key => new ConcurrentBag<string>());
```
