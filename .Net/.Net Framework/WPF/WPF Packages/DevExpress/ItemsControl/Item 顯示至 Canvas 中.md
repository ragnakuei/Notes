# Item 顯示至 Canvas 中

由 ViewModel 給定 
1. Label 的 Content
1. Label 的 Left
1. Label 的 Top

```xml
<Window
    x:Class="WpfApp3.MainWindow"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:local="clr-namespace:WpfApp3"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
    Title="MainWindow"
    Width="800"
    Height="450"
    mc:Ignorable="d">
    <Window.DataContext>
        <local:MainWindowViewModel />
    </Window.DataContext>
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:EventToCommand Command="{Binding OnLoadedCommand}" EventName="Loaded" />
    </dxmvvm:Interaction.Behaviors>
    <Grid>
        <ItemsControl ItemsSource="{Binding Tests}">
            <ItemsControl.ItemsPanel>
                <ItemsPanelTemplate>
                    <Canvas />
                </ItemsPanelTemplate>
            </ItemsControl.ItemsPanel>
            <ItemsControl.ItemTemplate>
                <DataTemplate DataType="{x:Type local:Test}">
                    <Label Content="{Binding Content}" />
                </DataTemplate>
            </ItemsControl.ItemTemplate>
            <ItemsControl.ItemContainerStyle>
                <Style TargetType="FrameworkElement">
                    <Setter Property="Canvas.Left" Value="{Binding Left}"/>
                    <Setter Property="Canvas.Top" Value="{Binding Top}"/>
                </Style>
            </ItemsControl.ItemContainerStyle>
        </ItemsControl>
    </Grid>
</Window>
```

```csharp
using System.Collections.ObjectModel;
using System.Windows.Controls;
using System.Windows.Input;
using DevExpress.Mvvm;

namespace WpfApp3
{
    public class MainWindowViewModel : ViewModelBase
    {
        public MainWindowViewModel()
        {
        }

        public ObservableCollection<Test> Tests { get; set; } = new ObservableCollection<Test>
        {
            new Test
            {
                Left = 50,
                Top = 50,
                Content = "A"
            },
            new Test
            {
                Left = 100,
                Top = 50,
                Content = "B"
            },
            new Test
            {
                Left = 150,
                Top = 50,
                Content = "C"
            },
        };
    }

    public class Test
    {
        public string Content { get; set; }
        public double Left { get; set; }
        public double Top { get; set; }
    }
}
```