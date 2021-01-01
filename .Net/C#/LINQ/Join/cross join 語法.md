# cross join 語法

## 範例

```csharp
var ints =  Enumerable.Range(1, 9);

//ints.SelectMany(i1 => ints, (i1, i2) => (i1, i2)).Dump();

(from i1 in ints
    join i2 in ints
    on 1 equals 1
select (i1, i2)).Dump();
```
