# Progress

- 設定 BackgroundWorker.WorkerReportsProgress = true 開啟此功能
- 透過 BackgroundWorker.ReportProgress(int) 來更新 ProgressPercentage
- 在 BackgroundWorker.ProgressChanged 時，就可以從  ProgressChangedEventArgs.ProgressPercentage 取出
- ProgressPercentage 資料型態是 int
- ProgressChanged 所呼叫的 method 是 UI Thread 

---

```csharp
private BackgroundWorker backGroundWorker = new BackgroundWorker();

void Main()
{
    backGroundWorker.WorkerReportsProgress = true;
    backGroundWorker.WorkerSupportsCancellation = true;

    backGroundWorker.DoWork += RunTask;
    backGroundWorker.ProgressChanged += new ProgressChangedEventHandler(TaskProgressChanged);
    backGroundWorker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(TaskCompleted);

    backGroundWorker.RunWorkerAsync();
    Thread.Sleep(500);

    backGroundWorker.ReportProgress(-1);         // 1
    Thread.Sleep(500);

    backGroundWorker.CancelAsync();
}


private void RunTask(object sender, DoWorkEventArgs e)
{
    var target = (sender as BackgroundWorker);

    for (int i = 0; i < 100; i++)
    {
        if ((backGroundWorker.CancellationPending == true))
        {
            e.Cancel = true;
            break;
        }

        target.ReportProgress(i);                // 2

        Thread.Sleep(100);
    }
}

private void TaskProgressChanged(object sender, ProgressChangedEventArgs e)
{
    $"ProgressPercentage:{e.ProgressPercentage}".Dump();  // 3
    "------------------------------------".Dump();
}

private void TaskCompleted(object sender, RunWorkerCompletedEventArgs e)
{
    "TaskCompleted".Dump();
}
```
