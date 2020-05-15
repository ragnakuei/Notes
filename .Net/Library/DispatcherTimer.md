# DispatcherTimer

更新間隔可以設定到 1ms

```csharp
DispatcherTimer timer = new DispatcherTimer();
timer.Interval = TimeSpan.FromMilliseconds(1);
timer.Tick += timer_Tick;
timer.Start();

private void timer_Tick(object? sender, EventArgs e)
{
    Now = DateTime.Now.ToString("HH:mm:ss.fff");
}
```
