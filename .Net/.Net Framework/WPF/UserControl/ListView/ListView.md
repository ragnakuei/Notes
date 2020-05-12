# [ListView](https://docs.microsoft.com/zh-tw/dotnet/api/system.windows.controls.listview)

- [OverView](https://docs.microsoft.com/zh-tw/dotnet/framework/wpf/controls/listview-overview)



## 透過 DataContext Binding

```csharp
public class DocumentViewModel : ViewModelBase
{
    public string[] Titles { get; } = new[]
                                        {
                                            "Test1",
                                            "Test2"
                                        };
}
```

```xml
<ListView ItemsSource="{Binding Titles}" Grid.Row="3">
    <ListView.ItemTemplate>
        <DataTemplate>
            <TextBlock Text="{Binding}"></TextBlock>
        </DataTemplate>
    </ListView.ItemTemplate>
</ListView>
```

## DataTemplate 內文字不換行做法

1. 加上 StackPanel
1. 加上 Attribute `HorizontalAlignment="Right"`

```xml
<ListView ItemsSource="{Binding OrderList}" Grid.Row="1">
    <ListView.ItemTemplate>
        <DataTemplate>
            <StackPanel Orientation="Horizontal">
                <TextBlock Text="{Binding OrderId}" />
                <TextBlock Text=" "
                            HorizontalAlignment="Right" />
                <TextBlock Text="{Binding OrderId}"
                            HorizontalAlignment="Right" />
            </StackPanel>
        </DataTemplate>
    </ListView.ItemTemplate>
</ListView>
```
