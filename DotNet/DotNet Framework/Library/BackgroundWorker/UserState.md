# UserState

- 跟 Progress 的做法差不多
- 設定 BackgroundWorker.WorkerReportsProgress = true 開啟此功能
- 值的給定是透過 BackgroundWorker.ReportProgress(int, object) 第二個參數
- 值的取出是在 BackgroundWorker.ProgressChanged 時，從  ProgressChangedEventArgs.UserState 取出

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

    backGroundWorker.ReportProgress(-1, "z");    // 1
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

        target.ReportProgress(i, (char)(97 + i));    // 2

        Thread.Sleep(100);
    }
}

private void TaskProgressChanged(object sender, ProgressChangedEventArgs e)
{
    $"UserState:{e.UserState}".Dump();               // 3
    "------------------------------------".Dump();
}

private void TaskCompleted(object sender, RunWorkerCompletedEventArgs e)
{
    "TaskCompleted".Dump();
}
```
