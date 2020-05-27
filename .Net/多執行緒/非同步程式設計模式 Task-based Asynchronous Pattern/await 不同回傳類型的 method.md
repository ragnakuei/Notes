# await 不同回傳類型的 method

```csharp
async Task Main()
{
    var a = A();
    var b = B();
    
    await Task.WhenAll(a, b);
    
    (await a).Dump();
    (await b).Dump();
}

private async Task<int> A()
{
    await Task.Delay(1000);
    return await Task.FromResult(1);
}

private async Task<string> B()
{
    await Task.Delay(1000);
    return await Task.FromResult("2");
}
```