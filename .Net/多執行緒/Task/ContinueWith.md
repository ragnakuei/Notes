# ContinueWith


```cs
var cts = new CancellationTokenSource();

var task1 = Task.Run(() =>
{
    "Task1.Running".Dump();
});

var task2 = task1.ContinueWith(t =>
{
    "Task2.Running".Dump();

    // 模擬發生 Exception 的情況
    throw new Exception("Test");
});

task2.ContinueWith(t =>
{
    // task2 執行成功時才會執行的地方
    "Task2.Complete".Dump();
}, TaskContinuationOptions.OnlyOnRanToCompletion);

task2.ContinueWith(t =>
{
    // task2 執行失敗時才會執行的地方
    "Task2.Exception".Dump();
    t.Dump();
}, TaskContinuationOptions.OnlyOnFaulted);
```