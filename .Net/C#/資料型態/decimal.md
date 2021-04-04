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
