    # ToString

## 整數格式化

```csharp
var i = 123456789;
i.ToString("### ### ###").Dump();
```

可以產生 `123 456 789` 的效果


## 科學記號輸出

- [自訂格式](https://docs.microsoft.com/zh-tw/dotnet/standard/base-types/custom-numeric-format-strings#the-e-and-e-custom-specifiers)

```csharp
float f = 1e-1f;
f.Dump();

f.ToString("E").Dump();
f.ToString("0.00e+0").Dump();
f.ToString("0.000E+00").Dump();
f.ToString("0.##e+0").Dump();
f.ToString("0.###E+00").Dump();
```