# ApplicationCommands.Close

---

## 範例

給定一個 Button 來關閉 Window

語法關聯如下:

1. 在 Window 下
   - 新增 Window.CommandBindings
   - 於裡面新增 CommandBinding
     - Command 為 ApplicationCommands.Close
     - Executed 為 cs 內的 event
1. 在 Window 內
   - 新增 Button
     - Command 為 ApplicationCommands.Close

關鍵點

- 以下二個 Command 要一致，否則會讓 Button 處於 Disabled 的狀態
  - Window.CommandBindings > CommandBinding > Command
  - Button.Command


```xml
<Window x:Class="WpfApp15.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp15"
        xmlns:system="clr-namespace:System;assembly=System.Runtime"
        mc:Ignorable="d"
        Name="wnd"
        Title="MainWindow" Height="450" Width="800">
    <Window.DataContext>
        <local:MainViewModel />
    </Window.DataContext>
    <Window.CommandBindings>
        <CommandBinding Command="ApplicationCommands.Close"
                        Executed="CloseCommandHandler"/>
    </Window.CommandBindings>
    <StackPanel Margin="15">
        <Button Command="ApplicationCommands.Close"
                Content="Close Window" />
    </StackPanel>
</Window>
```

```csharp
public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
    }

    private void CloseCommandHandler(object sender, ExecutedRoutedEventArgs e)
    {
        this.Close();
    }
}
```
