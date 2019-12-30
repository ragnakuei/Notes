# [GridView](https://docs.microsoft.com/en-us/dotnet/api/system.windows.controls.gridview)

## Sample01

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

---

## Sample02

```xml
<ListView Margin="10" Name="lvUsers">
    <ListView.View>
        <GridView>
            <GridViewColumn Header="Name" Width="120" DisplayMemberBinding="{Binding Name}" />
            <GridViewColumn Header="Age" Width="50" DisplayMemberBinding="{Binding Age}" />

            <!-- 原本顯示欄位的語法 -->
            <GridViewColumn Header="Mail" Width="150" DisplayMemberBinding="{Binding Mail}"/>

            <!-- 調整成為可點選的藍字語法。 注意：沒有 DisplayMemberBinding Attribute 了 ! -->
            <GridViewColumn Header="Mail" Width="150" >
                <GridViewColumn.CellTemplate>
                    <DataTemplate>
                        <TextBlock Text="{Binding Mail}" TextDecorations="Underline" Foreground="Red" Cursor="Hand" />
                    </DataTemplate>
                </GridViewColumn.CellTemplate>
            </GridViewColumn>
        </GridView>
    </ListView.View>
</ListView>
```
