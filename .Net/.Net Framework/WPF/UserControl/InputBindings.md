# InputBindings

- [InputBindings](#inputbindings)
  - [Sample：套用至 Image 上](#sample%e5%a5%97%e7%94%a8%e8%87%b3-image-%e4%b8%8a)


---

[MouseAction](https://docs.microsoft.com/zh-tw/dotnet/api/system.windows.input.mouseaction) 是 [Gesture](https://docs.microsoft.com/zh-tw/dotnet/api/system.windows.input.mousebinding.gesture) 子集


---

## Sample：套用至 Image 上

View

```xml
<Window x:Class="WpfApp1.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp1"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.DataContext>
        <local:MainWindowViewModel/>
    </Window.DataContext>
    <StackPanel Height="auto" Width="auto">
        <Image Source="./Desert.jpg" VerticalAlignment="Top" Cursor="Hand">
            <Image.InputBindings>
                <MouseBinding Gesture="LeftClick" Command="{Binding ClickImageCommand, Mode=OneTime}" />
                <!--<MouseBinding MouseAction="LeftClick" Command="{Binding ClickImageCommand, Mode=OneTime}" />-->
            </Image.InputBindings>
        </Image>
    </StackPanel>
</Window>
```

ViewModel

```csharp
public class MainWindowViewModel
{
    public MainWindowViewModel()
    {
        ConfirmOnClickCommand = new ConfirmClickCommand(ConfirmOnClickExecute);

        var c = new Canvas();
        //c.MouseLeftButtonDown
    }

    private void ConfirmOnClickExecute()
    {
        MessageBox.Show("Ok");
    }

    public ICommand ConfirmOnClickCommand { get; set; }

    private class ConfirmClickCommand : BaseCommand
    {
        public ConfirmClickCommand(Action execute)
            : base(execute)
        {
        }

        public ConfirmClickCommand(Action execute, Func<bool> canExecute)
            : base(execute, canExecute)
        {
        }
    }
}
```
