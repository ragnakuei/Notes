# SpinWait.SpinUntil

比較像 do while 加上 Thread.Sleep() 的處理方式

```csharp
Stopwatch sw = new Stopwatch();
sw.Start();
SpinWait.SpinUntil(() => {
    sw.ElapsedMilliseconds.Dump();
    return false;
}, 100);
sw.Stop();
"Complete".Dump();
```

```csharp
public partial class MainWindow : Window
{
    private readonly SynchronizationContext _currentSynchronizationContext;

    public MainWindow()
    {
        InitializeComponent();
        _currentSynchronizationContext = SynchronizationContext.Current;
    }

    private void Button_Click(object sender, RoutedEventArgs e)
    {
        if(this.btn.Content.Equals("Running"))
        {
            return;
        }

        _currentSynchronizationContext.Post(_ => { this.btn.Content = "Running"; }, null);

        var newTask = Task.Factory.StartNew(() =>
        {
            _currentSynchronizationContext.Post(_ => { this.btn.Content = "Running"; }, null);

            int result = 0;
            for (int i = 0; i < 10000; i++)
            {
                result++;

                // false 持續執行
                SpinWait.SpinUntil(() => false, 1);
                _currentSynchronizationContext.Post(_ => { this.lbl.Content = result.ToString(); }, null);
            }

            _currentSynchronizationContext.Post(_ => { this.btn.Content = "Complete"; }, null);
        });
    }
}
```