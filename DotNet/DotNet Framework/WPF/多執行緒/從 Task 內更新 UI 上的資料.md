# 從 Task 內更新 UI 上的資料

```xml
<StackPanel>
    <Label Name="lbl"></Label>
    <Button x:Name="btn" Click="Button_Click">Start</Button>
</StackPanel>
```

```csharp
private void Button_Click(object sender, RoutedEventArgs e)
{
    if (! _lastTask.IsCompleted
        || _lastTask.Status == TaskStatus.Running)
    {
        return;
    }

    _lastTask = Task.Factory.StartNew(() =>
                                        {
                                            _currentSynchronizationContext.Post(_ =>
                                                                                {
                                                                                    this.btn.Content = "Running";
                                                                                }, null);
                                            for (int i = 0 ; i < 10 ; i++)
                                            {
                                                SpinWait.SpinUntil(() => false, 100);
                                                _currentSynchronizationContext.Post(_ =>
                                                                                    {
                                                                                        this.lbl.Content = i.ToString();
                                                                                    }, null);
                                            }
                                        })
                    .ContinueWith((t) =>
                                    {
                                        _currentSynchronizationContext.Post(_ =>
                                                                            {
                                                                                this.btn.Content = "Finished";
                                                                            }, null);
                                    });
}
```