# ImmutableDictionary

- 不可變的 Dictionary<TKey, TValue>
- Thread Safe

---

## 範例一

```csharp
var builder = ImmutableDictionary.CreateBuilder<string, int>();
builder.Add("a", 1);
builder.Add("b", 2);

var result = builder.ToImmutable();
result.Add("c", 3);  // 不會加到 result 中，也不會產生 Exception
result.Dump();
```

---

## 範例二

```csharp
var dict = new Dictionary<string, int>
{
    ["a"] = 1,
    ["b"] = 2
};

var result = dict.ToImmutableDictionary();
result.Add("c", 3);  // 不會加到 result 中，也不會產生 Exception
result.Dump();
```
