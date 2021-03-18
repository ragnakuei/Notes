# [Asynchronous streams](https://docs.microsoft.com/zh-tw/dotnet/csharp/whats-new/csharp-8#asynchronous-streams)

```csharp
async Task Main()
{
	await foreach (var number in GenerateSequenceAsync())
	{
		Console.WriteLine(number);
	}
}

public static async IAsyncEnumerable<int> GenerateSequenceAsync()
{
	for (int i = 0; i < 10; i++)
	{
		 $"ManagedThreadId:{Thread.CurrentThread.ManagedThreadId}".Dump();
		 
		await Task.Delay(100);
		yield return i;
	}
}
```