# Argument

- 在 BackgroundWorker.RunWorkerAsync() 中給定 Argument
- 在 RunTask 時，可以從 DoWorkEventArgs.Argument 取出

---

```csharp
private BackgroundWorker backGroundWorker = new BackgroundWorker();

void Main()
{
    backGroundWorker.WorkerSupportsCancellation = true;
    backGroundWorker.DoWork += new DoWorkEventHandler(RunTask);
    backGroundWorker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(TaskCompleted);

    backGroundWorker.RunWorkerAsync(1000);    // 1
    Thread.Sleep(1000);

    backGroundWorker.CancelAsync();
}

private void RunTask(object sender, DoWorkEventArgs e)
{
    $"Argument:{e.Argument}".Dump();          // 2

    while (true)
    {
        if ((backGroundWorker.CancellationPending == true))
        {
            e.Cancel = true;
            break;
        }

        "Running".Dump();
        Thread.Sleep(100);
    }
}

private void TaskCompleted(object sender, RunWorkerCompletedEventArgs e)
{
    "TaskCompleted".Dump();
}
```
