# Collection Initialization

```csharp
void Main()
{
    var temp = new PairList<int, string>
    {
        {0, "bob"},
        {1, "phil"},
        {2, "nick"},
        {3, "nick", new {Id = 1}},
    };

    temp.Dump();
}

class PairList<T1, T2> : IEnumerable
{
    private Dictionary<T1, T2> _list = new Dictionary<T1, T2>();

    public void Add(T1 arg1, T2 arg2, object arg3)
    {
        _list.Add(arg1, arg2);
    }

    public void Add(T1 arg1, T2 arg2)
    {
        _list.Add(arg1, arg2);
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return _list.GetEnumerator();
    }
}
```

參考資料:

    [Fun with Custom C# Collection Initializers](https://mariusschulz.com/blog/fun-with-custom-csharp-collection-initializers)