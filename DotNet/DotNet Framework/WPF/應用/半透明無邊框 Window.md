# 半透明無邊框 Window


---

## 半透明底色

```xml
<Window x:Class="WpfApp10.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp10"
        mc:Ignorable="d"
        Title="MainWindow" Height="300" Width="300"

        AllowsTransparency = "True"
        WindowStyle = "None"
        MouseLeftButtonDown="Window_MouseLeftButtonDown">
    <Window.Background>
        <SolidColorBrush Color="#7F0000FF" Opacity="0.1"/>
    </Window.Background>
    <Grid>
        <Button Margin="285,0,0,285"
                Height="15"
                Width="15"
                Name="btnClose"
                Click="btnCloseClick"
                VerticalAlignment="Center"
                HorizontalAlignment="Center"
                Background="Red"
                Foreground="White"
                FontSize="9">X</Button>
    </Grid>
</Window>
```

```csharp
public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
    }

    // 允許直接點擊 Window 來拖曳
    private void Window_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
    {
        this.DragMove();
    }

    // 關閉按鈕事件
    private void btnCloseClick(object sender, RoutedEventArgs e)
    {
        this.Close();
    }
}
```

## 全透明底色

把 [半透明底色](#%e5%8d%8a%e9%80%8f%e6%98%8e%e5%ba%95%e8%89%b2) 的 Background 改成以下的值

> Background = "Transparent"

缺點是整個 Window 會變成無法拖曳。但可以透過 Label 或是某些控制項來拖曳。

