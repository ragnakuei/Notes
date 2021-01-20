# Memory Storage 範例

套件
- Hangfire.Core
- Hangfire.AspNetCore
- Hangfire.MemoryStorage


## 範例

startup.cs > ConfigureServices()

```csharp
services.AddHangfire(configuration => configuration.UseMemoryStorage());
```

startup.cs > Configure()

```csharp
app.UseHangfireServer();
```

Controller

```csharp
public class HomeController : Controller
{
    public IActionResult Index()
    {
        return View();
    }

    [HttpPost]
    public IActionResult TriggerBackgrounWork01()
    {
        var jobId = BackgroundJob.Enqueue(() => Console.WriteLine("BackgrounWork01"));

        return Ok(jobId);
    }

    [HttpPost]
    public IActionResult TriggerBackgrounWork02()
    {
        // 建立 Job 時，IJobCancellationToken 給定 JobCancellationToken.Null 就可以
        var jobId = BackgroundJob.Enqueue(() => LongTermJob(JobCancellationToken.Null));

        return Ok(jobId);
    }

    // BackgroundJob.Enqueue() 所指定的 method 必須是 public
    // 如果要讓 Job 可以被刪除，就要加 IJobCancellationToken 參數
    public void LongTermJob(IJobCancellationToken cancellationToken)
    {
        for (int i = 0; i < 100_0000; i++)
        {
            // 判斷是否被取消
            cancellationToken.ThrowIfCancellationRequested();

            Thread.Sleep(1000);
            Console.WriteLine(DateTime.Now.ToString());
        }
    }

    /// <summary>
    /// 取得 jobId 狀態
    /// </summary>
    [HttpPost]
    public IActionResult GetJobStatus(string jobId)
    {
        var result = string.Empty;

        using (var connection = JobStorage.Current.GetConnection())
        {
            // var jobData  = connection.GetJobData("job-id");
            var jobState = connection.GetStateData(jobId);
            result = jobState.Name;
        }

        return Ok(result);
    }

    /// <summary>
    /// 刪除 Job
    /// </summary>
    [HttpPost]
    public IActionResult DeleteJob(string jobId)
    {
        var result = BackgroundJob.Delete(jobId);

        return Ok(result);
    }
}
```