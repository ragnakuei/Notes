# TimeSpan

## 格式化輸出

```csharp
var t = new TimeSpan(1, 13,50,40);

t.ToString().Dump();

t.ToString(@"hh\:mm").Dump();
t.ToString(@"d\.hh\:mm").Dump();
t.ToString(@"d\.hh\:mm\:ss").Dump();
```