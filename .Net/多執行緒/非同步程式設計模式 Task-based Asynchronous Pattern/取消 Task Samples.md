# 取消 Task Samples

- 判斷 Task 完成的方式，不要用 [IsCompleted](https://docs.microsoft.com/zh-tw/dotnet/api/system.threading.tasks.task.iscompleted)，因為 IsCompleted，包含了 TaskStatus 的三種狀態：RanToCompletion, Faulted, Canceled

## Sample 1：以 同步方法呼叫 Task

要以 catch AggregateException 來抓出被取消的 Task

```csharp
void Main()
{
    // CancellationTokenSource cts = new CancellationTokenSource(100);
    CancellationTokenSource cts = new CancellationTokenSource();
    cts.CancelAfter(100);


    var tasks = new[]{
        PrintAsync(cts.Token),
        PrintAsync(cts.Token),
        PrintAsync(cts.Token),
    };

    try
    {
        Task.WaitAll(tasks);
    }
    catch (AggregateException)
    {
        // 判斷 Task 是否被取消
        foreach (var t in tasks.Where(t => t.IsCanceled))
        {
            Console.WriteLine($"Task Id:{t.Id} Canceled !!");
        }

        // 判斷 Task 是否有執行錯誤
        foreach (var t in tasks.Where(t => t.IsFaulted))
        {
            Console.WriteLine($"Task Id:{t.Id} Faulted !!");
        }
    }

    // 判斷 Task 完成的方式，不要用 IsCompleted，因為 IsCompleted，包含了 TaskStatus 的三種狀態：RanToCompletion, Faulted, Canceled
    // Reference：https://docs.microsoft.com/zh-tw/dotnet/api/system.threading.tasks.task.iscompleted
    foreach (var t in tasks.Where(t => t.Status == TaskStatus.RanToCompletion))
    {
        Console.WriteLine($"Task Id:{t.Id} Completed !!");
    }
}

private Task PrintAsync(CancellationToken token)
{
    return Task.Run(() =>
    {
        Thread.Sleep(1000);

        if (token.IsCancellationRequested)
        {
            // "Cancelled".Dump();
            token.ThrowIfCancellationRequested();
            return;
        }

        Console.WriteLine($"Thread Id:{Thread.CurrentThread.ManagedThreadId}");
    }, token);
}
```

## Sample 2：非同步方法呼叫

使用 TAP 時，就可以直接 catch OperationCanceledException 來做正確的處理

```csharp
async Task Main()
{
    CancellationTokenSource cts = new CancellationTokenSource(100);

    var tasks = new[]{
        PrintAsync(cts.Token),
        PrintAsync(cts.Token, true),
        PrintAsync(cts.Token),
    };

    try
    {
        await Task.WhenAll(tasks);
    }
    catch (OperationCanceledException)
    {
        foreach (var t in tasks.Where(t => t.IsCanceled))
        {
            Console.WriteLine($"Task Id:{t.Id} Canceled !!");
        }

        foreach (var t in tasks.Where(t => t.IsFaulted))
        {
            Console.WriteLine($"Task Id:{t.Id} Faulted !! {t.Exception.Message}");
        }
    }

    foreach (var t in tasks.Where(t => t.Status == TaskStatus.RanToCompletion))
    {
        Console.WriteLine($"Task Id:{t.Id} Completed !!");
    }
}

private async Task PrintAsync(CancellationToken token, bool hasError = false)
{
    await Task.Delay(1000);

    if (token.IsCancellationRequested)
    {
        // "Cancelled".Dump();
        token.ThrowIfCancellationRequested();
        return;
    }

    if (hasError)
    {
        throw new Exception("Test Error");
    }

    Console.WriteLine($"Thread Id:{Thread.CurrentThread.ManagedThreadId}");
}
```
