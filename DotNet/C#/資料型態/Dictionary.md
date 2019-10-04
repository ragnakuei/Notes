# Dictionary

二種初始化方式

```csharp
// 這個方式不適合用於 field 初始化
var dict1 = new Dictionary<int, string> {
    {1, "A"},
    {2, "B"},
    {3, "C"},
};

// 這個方式較通用
var dict2 = new Dictionary<int, string> {
    [1] = "A",
    [2] = "B",
    [3] = "C",
};
```
