# await 相同回傳類型的 method

透過 `Task.WhenAll(params Task<T>[])` 的回傳值，取得 T[] 的資料

引數的位置就會對應 T[index]  內的值

例：
- 第一個引數值，可以從 T[0] 取得
- 第二個引數值，可以從 T[1] 取得
- 餘類推

```csharp
async Task Main()
{
    var a = A();
    var b = B();
    
    var result = await Task.WhenAll(a, b);
    result[0].Dump();
    result[1].Dump();
    
    //(await a).Dump();
    //(await b).Dump();
}

private async Task<int> A()
{
    await Task.Delay(1000);
    return await Task.FromResult(1);
}

private async Task<int> B()
{
    await Task.Delay(1000);
    return await Task.FromResult(2);
}
```