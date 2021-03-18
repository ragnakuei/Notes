# 可透過 HorizontalContentAlignment 搭配 Grid 做垂直對齊

```xml
<Window x:Class="WpfApp15.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp15"
        xmlns:system="clr-namespace:System;assembly=System.Runtime"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.DataContext>
        <local:MainViewModel />
    </Window.DataContext>

    <StackPanel>
        <ListBox ItemsSource="{Binding Items}" HorizontalContentAlignment="Stretch" SelectionMode="Extended">
            <ListBox.ItemTemplate>
                <DataTemplate>
                    <Grid Margin="0,2">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*" />
                            <ColumnDefinition Width="100" />
                        </Grid.ColumnDefinitions>
                        <TextBlock Text="{Binding Title}" />
                        <ProgressBar Grid.Column="1" Minimum="0" Maximum="100" Value="{Binding Completion}" />
                    </Grid>
                </DataTemplate>
            </ListBox.ItemTemplate>
        </ListBox>
    </StackPanel>
</Window>
```

```csharp
public class MainViewModel
{
    public List<TodoItem> Items { get; }

    public MainViewModel()
    {
        Items = new List<TodoItem>
                {
                    new TodoItem
                    {
                        Title = "Complete this WPF tutorial",
                        Completion = 45
                    },
                    new TodoItem
                    {
                        Title = "Learn C#",
                        Completion = 80
                    },
                    new TodoItem
                    {
                        Title = "Wash the car",
                        Completion = 0
                    }
                };
    }

    public string Title { get; set; } = "Main Window Title";
}

public class TodoItem
{
    public string Title { get; set; }
    public int Completion { get; set; }
}
```
