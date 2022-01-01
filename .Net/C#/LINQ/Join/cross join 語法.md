# cross join 語法

## 二個集合範例

```cs
var ints =  Enumerable.Range(1, 9);

//ints.SelectMany(i1 => ints, (i1, i2) => (i1, i2)).Dump();

(from i1 in ints
    join i2 in ints
    on 1 equals 1
select (i1, i2)).Dump();
```

或是不用使用 join 語法，會更簡潔

```cs
var ints = Enumerable.Range(1, 9);

//ints.SelectMany(i1 => ints, (i1, i2) => (i1, i2)).Dump();

(from i1 in ints
 from i2 in ints
 select (i1, i2)).Dump();
 ```

## 三個集合範例

```cs
var numbers = Enumerable.Range(1,5);

(from i1 in numbers
from i2 in numbers
 from i3 in numbers
 select new {i1, i2, i3}).Dump();

numbers.SelectMany(i1 => numbers, (i1, i2) => new { i1, i2 })
       .SelectMany(i1i2 => numbers, (i1i2, i3) => new { i1i2.i1, i1i2.i2, i3 } )
       .Dump();
```
