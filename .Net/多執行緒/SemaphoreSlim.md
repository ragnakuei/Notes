# SemaphoreSlim

```cs
async Task Main()
{
    var queue = new QueueService();

    var taskCount = 10;

    var tasks = Enumerable.Range(1, taskCount)
                          .Select(i => queue.RunAsync(() => Add()))
                          .ToArray();

    queue.ReleaseSemaphoreSlim();

    await Task.WhenAll(tasks);

    sum.Dump();
}

public class QueueService
{
    public QueueService()
    {
        _semaphoreSlim = new SemaphoreSlim(0, SemaphoreSlimCount);
    }
    
    private readonly int SemaphoreSlimCount = 3;

    private readonly SemaphoreSlim _semaphoreSlim;

    public async Task RunAsync(Action action)
    {
        "SemaphoreSlim wait".Dump();
        await _semaphoreSlim.WaitAsync();
        try
        {
            action.Invoke();
            Thread.Sleep(1000);
        }
        finally
        {
            // 每個動作完畢後的釋放
            _semaphoreSlim.Release();
        }
    }

    public void ReleaseSemaphoreSlim()
    {
        "ReleaseSemaphoreSlim".Dump();

        // 靠這個動作來 release wait 的部份
        _semaphoreSlim.Release(SemaphoreSlimCount);
    }
}

private int sum = 0;

private void Add()
{
    $"start {DateTime.Now:mm:ss fffffff}".Dump();
    sum++;
    Thread.Sleep(100);
    $"end {DateTime.Now:mm:ss fffffff}".Dump();
}
```

