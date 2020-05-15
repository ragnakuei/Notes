# Resources

- 一定要定義 Key 值
- 一般用來指定
  - Data
  - DataTemplate
  - Style
- 讀取方式有二種

  - DynamicResource - 每次使用都會被讀取一次
  - StaticResource - 只會被讀取一次 (跟 Static 變數一樣的概念)

---

## Resource 的語法

- 放在最上層的 Element 內 - `SampleTemplate1`
- 放在最靠近的 Element 內 - `SampleTemplate2`

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
    <Window.Resources>
        <DataTemplate x:Key="SampleTemplate1">
            <StackPanel>
                <TextBlock Text="{Binding Path = OrderId}" />
                <TextBlock Text="{Binding Name}" />
            </StackPanel>
        </DataTemplate>
    </Window.Resources>
    <StackPanel>
        <StackPanel.Resources>
            <DataTemplate x:Key="SampleTemplate2">
                <StackPanel>
                    <TextBlock Text="{Binding Path = OrderId}" />
                    <TextBlock Text="{Binding Name}" />
                </StackPanel>
            </DataTemplate>
        </StackPanel.Resources>
        <ContentControl Content="{Binding Order}" ContentTemplate="{StaticResource SampleTemplate2}" />
    </StackPanel>
</Window>
```

---

參考資料

- https://www.wpf-tutorial.com/zh/12/wpf%E6%87%89%E7%94%A8%E7%A8%8B%E5%BC%8F/%E8%B3%87%E6%BA%90resources/
