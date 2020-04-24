# BackgroundWorker

- 可產生背景程式
- 支援`處理中`、`處理完成`事件
- 支援處理百分比的更新
- ProgressChanged 所呼叫的 method 是 UI Thread 

---

## [範例](http://blog.tonycube.com/2011/04/backgroundworker.html)

```csharp
private BackgroundWorker backGroundWorker = new BackgroundWorker();

void Main()
{
    backGroundWorker.WorkerReportsProgress = true;
    backGroundWorker.WorkerSupportsCancellation = true;

    backGroundWorker.DoWork += new DoWorkEventHandler(RunTask);
    backGroundWorker.ProgressChanged += new ProgressChangedEventHandler(TaskProgressChanged);
    backGroundWorker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(TaskCompleted);


    backGroundWorker.RunWorkerAsync();
    backGroundWorker.IsBusy.Dump();
    Thread.Sleep(1000);

    backGroundWorker.CancelAsync();
    backGroundWorker.IsBusy.Dump();
}

private void RunTask(object sender, DoWorkEventArgs e)
{
    while (true)
    {
        if ((backGroundWorker.CancellationPending == true))
        {
            e.Cancel = true;
            break;
        }

        "t".Dump();
        Thread.Sleep(100);
    }
}

private void TaskProgressChanged(object sender, ProgressChangedEventArgs e)
{
    "TaskProgressChanged".Dump();
}

private void TaskCompleted(object sender, RunWorkerCompletedEventArgs e)
{
    "TaskCompleted".Dump();
}
```
