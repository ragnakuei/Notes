# Task Status

| Task Status          | 說明                                                             |
| -------------------- | ---------------------------------------------------------------- |
| Created              | Task 剛建立                                                      |
| WaitingToRun         | 呼叫 Task 準備執行                                               |
| WaitingForActivation | 在 ContinueWith 等待前者的 Task 執行完成時的狀態                 |
| Running              | Task 執行中                                                      |
| RanToCompletion      | 已完成                                                           |
| Faulted              | 發生 Exception                                                   |
| Canceled             | 透過 CancellationToken.ThrowIfCancellationRequested() 觸發的狀態 |

```csharp
var task = new Task(() => {
    for (int i = 0; i < 10; i++)
    {
        Thread.Sleep(100);
    }
});

task.Status.Dump();
task.Start();
task.Status.Dump();
var subTask = task.ContinueWith(t =>
{
    $"SubTask2:{t.Status}".Dump();
});
$"SubTask1:{subTask.Status}".Dump();
task.Status.Dump();
task.Wait();
task.Status.Dump();
```

參考資料

- [Task 生命週期狀態](https://dotblogs.com.tw/yc421206/2013/05/15/104061)
