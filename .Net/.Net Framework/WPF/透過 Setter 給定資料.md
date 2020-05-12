# 透過 Setter 給定資料

要給定明確型別給 value，否則會判斷型別錯誤，而執行失敗 !

```csharp
AboutViewModel viewModel = new AboutViewModel();

if (WindowService is WindowService windowService)
{
    windowService.WindowShowMode = WindowShowMode.Dialog;
    Style windowStyle = new Style
    {
        TargetType = typeof(ThemedWindow),
        Setters =
        {
            new Setter(ThemedWindow.WidthProperty, (double)600),   // 1
            new Setter(ThemedWindow.HeightProperty, (double)300),  // 2
            new Setter(ThemedWindow.TitleProperty, "About"),
        }
    };
    
    windowService.WindowStyle = windowStyle;
}

WindowService.Show(nameof(AboutView), viewModel);
```