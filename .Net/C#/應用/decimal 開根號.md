#

[資料來源](https://stackoverflow.com/questions/4124189/performing-math-operations-on-decimal-datatype-in-c)

```csharp
/// <summary>
/// decimal 開根號
/// </summary>
public static decimal Sqrt(this decimal x)
{
    if (x < 0)
    {
        throw new OverflowException("Cannot calculate square root from a negative number");
    }

    // magic number ...
    decimal epsilon = 2;

    decimal current = (decimal)Math.Sqrt((double)x), previous;
    do
    {
        previous = current;
        if (previous == 0.0M) return 0;
        current = (previous + x / previous) / 2;
    }
    while (Math.Abs(previous - current) > epsilon);
    return current;
}
```