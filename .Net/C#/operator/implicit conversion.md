# implicit conversion

## 範例

```csharp
void Main()
{
    NullableDecimalString t1 = "1.0";
    t1.Dump();
    
    decimal? d1 = t1;
    d1.Dump();

    string s1 = t1;
    s1.Dump();

    NullableDecimalString t2 = 2.0m;
    t2.Dump();
    
    decimal? d2 = t2;
    d2.Dump();

    string s2 = t2;
    s2.Dump();
}

public class NullableDecimalString
{
    private string _str;

    private decimal? _dec;

    private NullableDecimalString(string s) => SetString(s);

    private NullableDecimalString(decimal? d) => SetDecimal(d);

    // = 右方是 string 時
    public static implicit operator NullableDecimalString(string s) => new NullableDecimalString(s);
    
    // = 右方是 decimal? 時
    public static implicit operator NullableDecimalString(decimal? d) => new NullableDecimalString(d);

    // = 左方是 string 時
    public static implicit operator string(NullableDecimalString c) => c._str;

    // = 左方是 decimal? 時
    public static implicit operator decimal?(NullableDecimalString c) => c._dec;

    public void SetString(string s)
    {
        _str = s;
        _dec = _str?.ToNullableDecimal();
    }

    public void SetDecimal(decimal? d)
    {
        _dec = d;
        _str = _dec.ToString();
    }
}
```