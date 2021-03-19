# [ExcelFunctions](https://numerics.mathdotnet.com/api/MathNet.Numerics/ExcelFunctions.htm)

- 提供部份對應至 Excel 的 Function 實作

```csharp
static void Main(string[] args)
{
    Console.WriteLine(TINV(0.05, 1));
    Console.WriteLine(TINV(0.05, 15));
}


private static double TINV(double probability, int degreeOfFreedom)
{
    double result = MathNet.Numerics.ExcelFunctions.TInv(probability, degreeOfFreedom);
    return result;
}
```