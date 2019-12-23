# ItemsControl

```xml
<Grid>
    <ItemsControl ItemsSource="{Binding OrderList}">
        <ItemsControl.ItemTemplate>
            <DataTemplate>
                <WrapPanel>
                    <TextBlock Text="{Binding OrderId}"></TextBlock>
                </WrapPanel>
            </DataTemplate>
        </ItemsControl.ItemTemplate>
    <ItemsControl>
</Grid>
```
