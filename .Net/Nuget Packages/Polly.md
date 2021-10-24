# Polly

參考資料
- [處理 Deadlock、網路瞬斷、伺服器忙線等暫時性故障的利器 - Polly](https://blog.darkthread.net/blog/polly/)
- [[.NET]開發人員不可缺少的重試處理利器 Polly](https://www.dotblogs.com.tw/yc421206/2020/12/23/how_to_use_polly)

### retry

- Exception Retry

```cs
async Task Main()
{
    var policy = Policy.Handle<RetryException>(ex =>
    {
        //PrintCurrentThreadId(-1);

        // 回傳是否要 retry
        return true;
    })
    .Retry(3);

    // 這個等於 參數 func return true !
    //var policy = Policy.Handle<RetryException>()
    //                   .Retry(3);

    #region 單一 task

    //try
    //{
    //    var threadId = Thread.CurrentThread.ManagedThreadId;
    //    //$"StartNew Task:ManagedThreadId:{threadId}".Dump();
    //    
    //    var result = policy.Execute<int>(() => GetValue(threadId));
    //    //$"End Task:ManagedThreadId:{Thread.CurrentThread.ManagedThreadId}".Dump();
    //    
    //    result.Dump();
    //}
    //catch (RetryException ex)
    //{
    //    throw new RetryException("到達 retry 上限", ex);
    //}

    #endregion

    #region 多個 task

    var tasks = Enumerable.Range(1, 10).Select((i) =>
    {
        return Task.Factory.StartNew(() =>
        {
            try
            {
                var threadId = Thread.CurrentThread.ManagedThreadId;
                    //$"StartNew Task:ManagedThreadId:{threadId}".Dump();
                    var result = policy.Execute<int>(() => GetValue(threadId));
                    //$"End Task:ManagedThreadId:{Thread.CurrentThread.ManagedThreadId}".Dump();
                    return result;
            }
            catch (RetryException ex)
            {
                throw new RetryException("到達 retry 上限", ex);
            }
        });
    });

    try
    {
        var succCount = (await Task.WhenAll(tasks)).Length;
        Console.WriteLine(succCount);
    }
    catch (AggregateException ex)
    {
        ex.Dump();
    }

    #endregion
}

private Random _random = new Random();

public int GetValue(int threadId)
{
    var randomValue = _random.Next(1, 11);

    if (randomValue <= 5)
    {
        //PrintCurrentThreadId(threadId);
        $"符合重試條件:{randomValue}".Dump();
        throw new RetryException($"符合重試條件:{randomValue}");
    }

    return randomValue;
}

void PrintCurrentThreadId(int threadId)
{
    $"ThreadId:{threadId}".Dump();
    $"ManagedThreadId:{Thread.CurrentThread.ManagedThreadId}".Dump();
}

public class RetryException : Exception
{
    public RetryException(string msg)
        : base(msg)
    {

    }

    public RetryException(string msg, Exception ex)
    : base(msg, ex)
    {

    }
}
```
