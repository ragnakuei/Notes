# 於 Design Time 給定 ViewModel

```xml
<Window x:Class="WpfApp2.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp2"
        xmlns:view="clr-namespace:WpfApp2.View"
        xmlns:viewModel="clr-namespace:WpfApp2.ViewModel"

        <!-- 於 Design Time 給定 ViewModel -->
        d:DataContext="{d:DesignInstance local:MainWindowViewModel,
                                         IsDesignTimeCreatable=True}"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.Resources>
        <DataTemplate DataType="{x:Type viewModel:MainViewModel}">
            <view:MainView />
        </DataTemplate>
    </Window.Resources>
    <StackPanel>
        <ContentControl Content="{Binding Content}" />
    </StackPanel>
</Window>
```