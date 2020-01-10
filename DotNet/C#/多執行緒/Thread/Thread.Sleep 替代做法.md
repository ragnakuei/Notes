# Thread.Sleep 替代做法

比較像 do while 加上 Thread.Sleep() 的處理方式

```csharp
SpinWait.SpinUntil(() =>
{
    _currentSynchronizationContext.Post(_ => { this.lbl.Content = result.ToString(); }, null);
    return false;
}, 1);
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
                SpinWait.SpinUntil(() =>
                {
                    _currentSynchronizationContext.Post(_ => { this.lbl.Content = result.ToString(); }, null);
                    return false;
                }, 1);
            }

            _currentSynchronizationContext.Post(_ => { this.btn.Content = "Complete"; }, null);
        });
    }
}
```