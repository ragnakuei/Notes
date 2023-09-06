# Timeout Rollback 實作

參考資料：
- [在一段時間後取消非同步工作 (C#)](https://docs.microsoft.com/zh-tw/dotnet/csharp/programming-guide/concepts/async/cancel-async-tasks-after-a-period-of-time)
- [工作取消](https://docs.microsoft.com/zh-tw/dotnet/standard/parallel-programming/task-cancellation)

## 範例 01

- 實務上，要把 CancellationToken 丟到正在作業的非同步工作中，這樣才能讓工作取消。

```cs
async Task Main()
{
	var cts = new CancellationTokenSource();
	cts.CancelAfter(1000);

	try
	{
		var filePath = @"C:\temp\internal-nlog.txt";		
		
		var fileContent = await ReadFileLinesAsync(filePath, cts.Token);
		fileContent.Dump();
	}
	catch (OperationCanceledException e)
	{
		Console.WriteLine($"{nameof(OperationCanceledException)} thrown with message: {e.Message}");
	}
	finally
	{
		cts.Dispose();
	}
}

async Task<string> ReadFileLinesAsync(string filePath, CancellationToken token)
{
	var stringBuilder = new StringBuilder();
	
	foreach (string line in System.IO.File.ReadLines(filePath))
	{
		stringBuilder.AppendLine(line);
		
		// 模擬 Delay
		await Task.Delay(100);
		
		if(token.IsCancellationRequested)
		{
			
            "ThrowIfCancellationRequested".Dump();
            // 這邊做清除 / Rollback 工作

			token.ThrowIfCancellationRequested();

            // 這邊不需要用 Break 離開 !
			// break;
		}
	}
	
	return stringBuilder.ToString();
}
```