# ItemsControl

```xml
<Grid>
    <ItemsControl ItemsSource="{Binding OrderList}">
        <ItemsControl.ItemTemplate>
            <DataTemplate>
                <TextBlock Text="{Binding OrderId}"></TextBlock>
            </DataTemplate>
        </ItemsControl.ItemTemplate>
    </ItemsControl>
</Grid>
```
