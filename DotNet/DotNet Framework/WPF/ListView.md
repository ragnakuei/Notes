# ListView

DataContext

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
            <WrapPanel>
                <TextBlock Text="{Binding}"></TextBlock>
            </WrapPanel>
        </DataTemplate>
    </ListView.ItemTemplate>
</ListView>
```
