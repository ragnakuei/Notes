# 從 Task 內更新 UI 上的資料

主要解決產生錯誤訊息 `The calling thread must be STA, because many UI components require this.` 的情境

## 方式一

透過 `Application.Current.Dispatcher.Invoke(Action)` 來執行需要 UI Thread 執行的動作

如果不這樣做

```csharp
private async Task<UserControlDto> CreateUserControlDto()
{
    return await Task.Run(() =>
                            {
                                UserControlDto dto = null;

                                Application.Current.Dispatcher.Invoke(() =>
                                                                    {
                                                                        CenterView      centerView = new CenterView();
                                                                        CenterViewModel viewModel  = centerView.DataContext as CenterViewModel;

                                                                        viewModel.UpdatePropertyPanelEvent += UpdatePropertyPanel;

                                                                        dto = new UserControlDto
                                                                                {
                                                                                    Type                      = TypeEnum.Test,
                                                                                    ToolboxContentView        = null,
                                                                                    CenterViews               = new List<LayoutPanel>(),
                                                                                    ToolBoxAndCenterViewModel = viewModel,
                                                                                };

                                                                        LayoutPanel layoutPanel = new LayoutPanel
                                                                                                    {
                                                                                                        Caption = "Test",
                                                                                                        Content = centerView
                                                                                                    };

                                                                        dto.CenterViews.Add(layoutPanel);
                                                                    });


                                return dto;
                            });
}
```

## 方式二

這個方式也可以用在 winform 上

```xml
<StackPanel>
    <Label Name="lbl"></Label>
    <Button x:Name="btn" Click="Button_Click">Start</Button>
</StackPanel>
```

```csharp
private SynchronizationContext _currentSynchronizationContext = SynchronizationContext.Current;

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
