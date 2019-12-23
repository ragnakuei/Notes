# [EventToCommand](https://documentation.devexpress.com/WPF/17369/MVVM-Framework/Behaviors/Predefined-Set/EventToCommand)

- [EventToCommand](#eventtocommand)
  - [ListView](#listview)
  - [GridView](#gridview)
  - [GridControl](#gridcontrol)
  - [Canvas](#canvas)

---

## ListView

- View

```xml
<ListView ItemsSource="{Binding OrderList}" Grid.Row="2">
    <!-- 當 Interaction.Behaviors 放在這裡時，就是一進入 ListView 就會觸發 Event  -->
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:EventToCommand EventName="MouseEnter" Command="{Binding MouseEnterListViewCommand}" />
    </dxmvvm:Interaction.Behaviors>
    <ListView.View>
        <GridView AllowsColumnReorder="true"
                    ColumnHeaderToolTip="Order Information">
            <GridViewColumn DisplayMemberBinding="{Binding Path=OrderId}"
                            Header="OrderId" Width="100" />

            <GridViewColumn DisplayMemberBinding="{Binding Path=CustomerId}"
                            Header="CustomerId"
                            Width="100" />
        </GridView>
    </ListView.View>
</ListView>
```

- ViewModel

```csharp
 public ICommand MouseEnterListViewCommand { get; private set; }

public OrderListViewModel()
{
    MouseEnterListViewCommand = new DelegateCommand(MouseEnterEvent, MouseEnterEventCanEnable);
}

private void MouseEnterEvent()
{
    MessageBox.Show("Success");
}

private bool MouseEnterEventCanEnable()
{
    return true;
}
```

---

## GridView

- 傳遞參數
- 抓出所選擇的項目
- 因為 ListView 的 ItemSource 是 `OrderListItem[]`，所以 SelectedItem 就會是 `OrderListItem`

- View

  ```xml
  <ListView Name="listView" ItemsSource="{Binding OrderList}" Grid.Row="2">
      <dxmvvm:Interaction.Behaviors>
          <dxmvvm:EventToCommand EventName="MouseDoubleClick"
                                  Command="{Binding MouseDoubleClickListViewCommand}"
                                  PassEventArgsToCommand="True"
                                  CommandParameter="{Binding Path=SelectedItem, ElementName=listView}"
                                  />
      </dxmvvm:Interaction.Behaviors>
      <ListView.View>
          <GridView AllowsColumnReorder="true"
                      ColumnHeaderToolTip="Order Information">

              <GridViewColumn DisplayMemberBinding="{Binding Path=OrderId}"
                              Header="OrderId" Width="100" />

              <GridViewColumn DisplayMemberBinding="{Binding Path=CustomerId}"
                              Header="CustomerId"
                              Width="100" />
          </GridView>
      </ListView.View>
  </ListView>
  ```

- ViewModel

  ```csharp
  public ICommand MouseDoubleClickListViewCommand { get; private set; }

  public OrderListViewModel()
  {
      MouseDoubleClickListViewCommand = new DelegateCommand<OrderListItem>(MouseDoubleClickListViewCommandEvent, MouseDoubleClickListViewCommandEventCanEnable);
  }

  private void MouseDoubleClickListViewCommandEvent(OrderListItem obj)
  {
      System.Windows.Forms.MessageBox.Show(JsonConvert.SerializeObject(obj));
  }

  private bool MouseDoubleClickListViewCommandEventCanEnable(OrderListItem arg)
  {
      return true;
  }
  ```

---

## GridControl

```xml
<Grid>
    <Grid.Resources>
        <converters:MouseButtonEventArgsToGridRowConverter x:Key="MouseArgsToRowConverter"/>
        <converters:FocusedColumnChangedEventArgsToFieldNameConverter x:Key="ColumnArgsToFieldNameConverter"/>
    </Grid.Resources>
    <Grid.RowDefinitions>
        <RowDefinition/>
        <RowDefinition Height="Auto"/>
    </Grid.RowDefinitions>
    <dxg:GridControl Name="gridControl1" ItemsSource="{Binding GridData}" AutoGenerateColumns="AddNew">
        <dxg:GridControl.View>
            <dxg:TableView Name="tableView1">
                <dxmvvm:Interaction.Triggers>
                    <dxmvvm:EventToCommand EventName="ShowingEditor" Command="{Binding IsEditingAllowedCommand}" PassEventArgsToCommand="True"/>
                    <dxmvvm:EventToCommand EventName="MouseDoubleClick" Command="{Binding ShowRowDetailsCommand}" EventArgsConverter="{StaticResource MouseArgsToRowConverter}" PassEventArgsToCommand="True"/>
                    <dxmvvm:EventToCommand EventName="Loaded" Command="{Binding Commands.BestFitColumns, ElementName=tableView1}"/>
                </dxmvvm:Interaction.Triggers>
            </dxg:TableView>
        </dxg:GridControl.View>
        <dxmvvm:Interaction.Triggers>
            <dxmvvm:EventToCommand EventName="CurrentColumnChanged" Command="{Binding UpdateStatusInfoCommand}" EventArgsConverter="{StaticResource ColumnArgsToFieldNameConverter}" PassEventArgsToCommand="True"/>
        </dxmvvm:Interaction.Triggers>
    </dxg:GridControl>
    <TextBlock Text="{Binding StatusInfo}" TextAlignment="Center" VerticalAlignment="Center" HorizontalAlignment="Center" Grid.Row="1"/>
</Grid>
```

---

## Canvas

以 DevExpress 本身是做不到的 EventToCommand 的

[參考資料](https://stackoverflow.com/questions/43949931/wpf-mvvm-canvas-clickevent)
