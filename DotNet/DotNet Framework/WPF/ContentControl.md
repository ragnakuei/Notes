# ContentControl

- 做單一 Object 的綁定
- 必須要額外指定 DataTemplate 並且指向該 Template




```xml
<Window x:Class="WpfApp6.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp6"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.DataContext>
        <local:MainViewModel />
    </Window.DataContext>
    <StackPanel>
        <StackPanel.Resources>
            <DataTemplate x:Key="SampleTemplate">
                <StackPanel>
                    <TextBlock Text="{Binding Path = OrderId}" />
                    <TextBlock Text="{Binding Name}" />
                </StackPanel>
            </DataTemplate>
        </StackPanel.Resources>
        <ContentControl Content="{Binding Order}" ContentTemplate="{StaticResource SampleTemplate}" />
    </StackPanel>
</Window>
```