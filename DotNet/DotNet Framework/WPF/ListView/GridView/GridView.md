# [GridView](https://docs.microsoft.com/en-us/dotnet/api/system.windows.controls.gridview)

```xml
<ListView ItemsSource="{Binding Path=ActiveCounters}">
    <ListView.View>
        <GridView>
            <GridViewColumn  Header="Name" DisplayMemberBinding="{Binding Path=Name}" />
            <GridViewColumn  Header="Value"  DisplayMemberBinding="{Binding Path=Value}" />
            <GridViewColumn  Header="As Of Date"  DisplayMemberBinding="{Binding Path=AsOfDate}" />
            <GridViewColumn  Header="Duration"  DisplayMemberBinding="{Binding Path=Duration}" />
            <GridViewColumn  Header="Last Modified Date"  DisplayMemberBinding="{Binding Path=Timestamp}" />
        </GridView>
    </ListView.View>
</ListView>
```

## 加上 ContextMenu

```xml
<ListView ItemsSource="{Binding OrderList}" Grid.Row="1">
    <ListView.View>
        <GridView AllowsColumnReorder="true"
                    ColumnHeaderToolTip="Order Information">
            <GridViewColumn DisplayMemberBinding="{Binding Path=OrderId}"
                            Header="OrderId" Width="100" />

            <GridViewColumn DisplayMemberBinding="{Binding Path=CustomerId}"
                            Header="CustomerId"
                            Width="100" />
            <GridViewColumn DisplayMemberBinding="{Binding Path=OrderId}" >
                <GridViewColumnHeader>
                    Last Name
                    <GridViewColumnHeader.ContextMenu>
                        <ContextMenu>
                            <MenuItem Header="Ascending" />
                            <MenuItem Header="Descending" />
                        </ContextMenu>
                    </GridViewColumnHeader.ContextMenu>
                </GridViewColumnHeader>
            </GridViewColumn>
        </GridView>
    </ListView.View>
</ListView>
```
