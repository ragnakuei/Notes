# decimal

```csharp
void Main()
{
    四捨五入(1.344m, 2);
    四捨五入(1.345m, 2);

    四捨五入(1.354m, 2);
    四捨五入(1.355m, 2);
}

private void 四捨五入(decimal d, int digits)
{
    decimal.Round(d, digits, MidpointRounding.AwayFromZero).Dump();
}
```

## 將 decimal 指定的小數位數補 0

```csharp
/// <summary>
/// 給定 2，就會產生 1.00m
/// </summary>
private static decimal GenerateFillTailZeroMultipler(int digits)
{
    if (digits <= 0)
    {
        return 0m;
    }

    var digitList = new List<string> { "1", "." };
    digitList.AddRange(Enumerable.Repeat("0", digits));

    var dInString = digitList.Join(string.Empty);

    return decimal.Parse(dInString);
}

/// <summary>
/// 四捨五入 + 補齊浮點數 0
/// </summary>
public static decimal ToFixAndFillTailZero(this decimal input, int digits)
{
    var fixValue = input.ToFix(digits);

    var fixValueStr = fixValue.ToString();

    var fillDigits = fixValueStr.Contains(".")
                            ? digits - fixValueStr.Split(".")[1].Length
                            : digits;

    // 0 * 1.00m 還是 0，不符合預期
    // 額外處理
    if (fixValue == 0m)
    {
        var zeroResultStrings = new List<string>
                                {
                                    "0",
                                    "."
                                };
        var floatZeros = Enumerable.Repeat("0", digits);

        zeroResultStrings.AddRange(floatZeros);

        return zeroResultStrings.Join(string.Empty).ToDecimal();
    }

    if (fillDigits > 0)
    {
        var fillTailZeroMultipler = GenerateFillTailZeroMultipler(fillDigits);

        var fixAndFillTailZero = fixValue * fillTailZeroMultipler;

        return fixAndFillTailZero;
    }

    return fixValue;
}

/// <summary>
/// 四捨五入
/// </summary>
public static decimal ToFix(this decimal input, int digits)
{
    return decimal.Round(input, digits, MidpointRounding.AwayFromZero);
}
```

## Parse Exponential Notation 的方式

```csharp
decimal.Parse("1e-10", System.Globalization.NumberStyles.Float).Dump();
```

