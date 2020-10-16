# [Indices and ragnes](https://docs.microsoft.com/zh-tw/dotnet/csharp/tutorials/ranges-indexes)

## Index Type

- ^0 - 使用這個，會出現 IndexOutOfRangeException
- 包含二個 read only Proeprty
  - Value 
    - int
    - IsFromEnd
      - true - 0 為第一個
      - false - 1 為最後一個
  - IsFromEnd
    - bool

```csharp
var cs = new[] { 'a', 'b', 'c', 'd', 'e' };
//var cs = new List<char> { 'a', 'b', 'c', 'd', 'e' };

Index last = ^1;

// 如果以 var 宣告，型別就會是 int，但不影響結果
 //var first = 0;
Index first = 0;

// e
cs[last].Dump();

// a
cs[first].Dump();
```

### ^n 取出集合倒數 nth 元素

```csharp
var cs = new[] { 'a', 'b', 'c', 'd', 'e' };

// List<T> 也適用
// var cs = new List<char> { 'a', 'b', 'c', 'd', 'e' };

// e
cs[^1].Dump();

// d
cs[^2].Dump();
```

## Range Type

- 有些語法是不含右邊邊界的元素 !
- `..` 就是 Range Type，左、右方都可以加上 Index Type

### .. 取出集合所有元素

```csharp
var cs = new[] { 'a', 'b', 'c', 'd', 'e' };
//var cs = new List<char> { 'a', 'b', 'c', 'd', 'e' };

// a、b、c、d、e
cs[..].Dump();
```

### ..n 取出集合前 n 個元素

```csharp
var cs = new[] { 'a', 'b', 'c', 'd', 'e' };
//var cs = new List<char> { 'a', 'b', 'c', 'd', 'e' };

// a、b
cs[..2].Dump();

// a、b、c
cs[..3].Dump();
```

### n.. 取出集合從 index 為 n 之後的所有元素

```csharp
var cs = new[] { 'a', 'b', 'c', 'd', 'e' };
//var cs = new List<char> { 'a', 'b', 'c', 'd', 'e' };

// c、d、e
cs[2..].Dump();

// d、e
cs[3..].Dump();
```


### n..m 取出集合從 index 為 n 至 m-1 的所有元素

```csharp
var cs = new[] { 'a', 'b', 'c', 'd', 'e' };
//var cs = new List<char> { 'a', 'b', 'c', 'd', 'e' };

// c
cs[2..3].Dump();

// d、e
cs[3..5].Dump();
```

### ^n.. 取出集合倒數 nth 個之後的所有元素

```csharp
var cs = new[] { 'a', 'b', 'c', 'd', 'e' };
//var cs = new List<char> { 'a', 'b', 'c', 'd', 'e' };

// d、e
cs[^2..].Dump();

// c、d、e
cs[^3..].Dump();
```

### ..^n 取出集合 index 為 0 至 nth-1 的所有元素

```csharp
var cs = new[] { 'a', 'b', 'c', 'd', 'e' };
//var cs = new List<char> { 'a', 'b', 'c', 'd', 'e' };

// a、b、c
cs[..^2].Dump();

// a、b
cs[..^3].Dump();
```

