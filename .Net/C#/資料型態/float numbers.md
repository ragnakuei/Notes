# float numbers

## 顯示科學符號

e / E 可自行決定顯示哪個符號

雖然 double 預設可直接顯示 9e-10 這樣的數值

但 decimal 就沒有 double 的規則

可直接輸出成字串來統一顯示的結果

### 通用 e 的輸出

預設可直接以 ToString("e") 來輸出

甚至可給定 e0~e9 來給定有效位數

```csharp
double d = 9e-10;
d.Dump();
d.ToString("e").Dump();
d.ToString("e2").Dump();

decimal m = 9e-28m;
m.Dump();
m.ToString("e").Dump();
m.ToString("e2").Dump();
```

輸出結果

```
9E-10
9.000000e-010
9.00e-010
0.0000000000000000000000000009
9.000000e-028
9.00e-028
```

### 格式化科學符號顯示

下面範例超過 decimal 的最大有效位數 28

`0.#e-00` 與 `#.#e-00` 相同意義

```csharp
decimal m = 987654321e-29m;
m.Dump();
m.ToString("e").Dump();
"---".Dump();
m.ToString("#.#e-00").Dump();
m.ToString("##.######e-00").Dump();
m.ToString("###.######e-00").Dump();
"---".Dump();
m.ToString("0.##e-00").Dump();
m.ToString("0.##e-000").Dump();
"---".Dump();
m.ToString("0.###e-00").Dump();
m.ToString("0.###e-000").Dump();
```

輸出結果

```
0.0000000000000000000098765432
9.876543e-021
---
9.9e-21
98.765432e-22
987.65432e-23
---
9.88e-21
9.88e-021
---
9.877e-21
9.877e-021
```
