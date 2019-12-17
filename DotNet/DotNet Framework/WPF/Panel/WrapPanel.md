# [WrapPanel](https://docs.microsoft.com/zh-tw/dotnet/api/system.windows.controls.wrappanel)

將包住的內容加上換行的處理

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