# IAsyncEnumerable

當一個 method 回傳 IAsyncEnumerable\<T> 時

在 foreach 前就可以用 await foreach 來 iterator 取出每個元素

## 範例

```csharp
async Task Main()
{
    await foreach (var i in GetSourceDataAsync(10))
    {
        i.Dump();
    }
}

private static async IAsyncEnumerable<int> GetSourceDataAsync(int count)
{
    foreach (var i in Enumerable.Range(1, count))
    {
        // 模擬作業時間
        await Task.Delay(50);

        yield return i;
    }
}
```

## 參考資料

- [Async Streams with IAsyncEnumerable in .NET Core 3](https://anthonychu.ca/post/async-streams-dotnet-core-3-iasyncenumerable/)
