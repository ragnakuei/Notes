# [EventToCommand](https://documentation.devexpress.com/WPF/17369/MVVM-Framework/Behaviors/Predefined-Set/EventToCommand)

- [EventToCommand](#eventtocommand)
  - [語法](#%e8%aa%9e%e6%b3%95)
  - [ListView](#listview)
  - [GridView](#gridview)
  - [GridControl](#gridcontrol)
  - [Canvas](#canvas)
  - [Window](#window)
  - [PassEventArgsToCommand](#passeventargstocommand)

---

Assembly：DevExpress.Xpf.Core

---

## 語法

1. EventName

   直接指定 Event 的名稱

   ```xml
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:EventToCommand EventName="MouseEnter" Command="{Binding MouseEnterListViewCommand}" />
    </dxmvvm:Interaction.Behaviors>
   ```

1. Event

   指定 Event 的名稱及所在的 Type

   ```xml
    <TextBox>
        <dxmvvm:Interaction.Behaviors>
            <dxmvvm:EventToCommand Command="{Binding TextChangedCommand}" Event="TextBoxBase.TextChanged" />
        </dxmvvm:Interaction.Behaviors>
    </TextBox>
   ```

1. 在 Element 外部指定 Behavior

   ```xml
   <UserControl ...>

       <dxmvvm:Interaction.Behaviors>
           <dxmvvm:EventToCommand SourceName="list"    EventName="MouseDoubleClick" Command="{Binding InitializeCommand}"/>
           <dxmvvm:EventToCommand SourceObject="{Binding ElementName=list}"    EventName="MouseDoubleClick" Command="{Binding InitializeCommand}"/>
       </dxmvvm:Interaction.Behaviors>

           <ListBox x:Name="list" ... />

   </UserControl>
   ```

1. 傳遞參數

   - PassEventArgsToCommand
   - CommandParameter

   ```xml
   <ListView Name="listView" ItemsSource="{Binding OrderList}" Grid.Row="2">
       <dxmvvm:Interaction.Behaviors>
           <dxmvvm:EventToCommand EventName="MouseDoubleClick"
                                   Command="{Binding    MouseDoubleClickListViewCommand}"
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

1. 搭配鍵盤

   - ModifierKeys

   ```xml
   <dxmvvm:Interaction.Behaviors>
       <dxmvvm:EventToCommand EventName="MouseLeftButtonUp" Command="{Binding    EditCommand}" ModifierKeys="Ctrl+Alt">
           <dxmvvm:EventToCommand.EventArgsConverter>
               <Common:ListBoxEventArgsConverter/>
           </dxmvvm:EventToCommand.EventArgsConverter>
       </dxmvvm:EventToCommand>
   </dxmvvm:Interaction.Behaviors>
   ```

1. 取得 sender 及 EventArgs 範例

語法

```xml
<dxmvvm:Interaction.Behaviors>
    <dxmvvm:EventToCommand
        Command="{Binding OnAccordionItemPreviewMouseLeftButtonDownCommand}"
        EventName="PreviewMouseLeftButtonDown"
        PassEventArgsToCommand="True" />
</dxmvvm:Interaction.Behaviors>
```

直接給定 DelegateCommand\<T> 為 DelegateCommand\<EventArgs> 後

- EventArgs 為該 Event 所對應的 EventArgs

- EventArgs.Source 為該 Event 的 sender

1. 取得 EventToCommand 範例

語法

```xml
<dxmvvm:Interaction.Behaviors>
    <dxmvvm:EventToCommand
        Command="{Binding OnAccordionItemPreviewMouseLeftButtonDownCommand}"
        CommandParameter="{Binding RelativeSource={RelativeSource Self}}"
        EventName="PreviewMouseLeftButtonDown"
        PassEventArgsToCommand="True" />
```

這樣就可以從 DelegateCommand\<EventToCommand> 來取出該物件資料

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
- Event 效果

  - MouseUp 的效果會比 MouseDown 好
  - MouseLeftButtonUp 的效果會比 MouseLeftButtonDown 好

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

- View

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

---

## Window

- View

  ```xml
  <dxr:DXRibbonWindow xmlns:dxdiag="http://schemas.devexpress.com/winfx/2008/xaml/diagram"
                      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                      xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
                      xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
                      xmlns:dxr="http://schemas.devexpress.com/winfx/2008/xaml/ribbon"
                      xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
                      xmlns:d1="clr-namespace:WpfSample01.D"
                      x:Class="WpfSample01.D.DView"
                      mc:Ignorable="d"
                      d:DesignHeight="300" d:DesignWidth="300">
      <dxr:DXRibbonWindow.DataContext>
          <d1:DViewModel />
      </dxr:DXRibbonWindow.DataContext>
      <dxmvvm:Interaction.Behaviors>
          <dxmvvm:CurrentWindowService />
          <dxmvvm:EventToCommand EventName="Loaded" Command="{Binding OnLoadedCommand}" />
      </dxmvvm:Interaction.Behaviors>
      <Grid>

      </Grid>
  </dxr:DXRibbonWindow>
  ```

- ViewModel

  ```csharp
  public class DViewModel : ViewModelBase
  {
      public DViewModel()
      {
          OnLoadedCommand = new DelegateCommand(OnLoadedCommandExecute, OnLoadedCommandCanEnable);
      }

      private ICurrentWindowService _currentWindowService
      {
          get => GetService<ICurrentWindowService>();
      }

      private DView ViewClass
      {
          get => (_currentWindowService as CurrentWindowService)?.ActualWindow as DView;
      }

      #region View Related Event

      public ICommand OnLoadedCommand { get; private set; }

      private void OnLoadedCommandExecute()
      {
          var svgFilePath = Path.Combine(
                                          AppDomain.CurrentDomain.BaseDirectory,
                                          "Images",
                                          "NoteBook 1.svg"
                                          );

          new DragDropSvgImage(ViewClass.canvasLayout, svgFilePath)
                      {
                          Width = 100,
                          Margin = new Thickness
                                  {
                                      Left = 0,
                                      Top = 0
                                  }
                      };
      }

      private bool OnLoadedCommandCanEnable()
      {
          return true;
      }

      #endregion
  }
  ```

## PassEventArgsToCommand

給定 bool 值，可以把`事件參數`傳至 ICommand\<T> 中

```xml
<Border x:Name="svgContainerBorder"
        Background="#ecf0f4"
        BorderThickness="10"
        CornerRadius="10"
        ClipToBounds="True"
        BorderBrush="Black">
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:EventToCommand EventName="MouseDown"
                                PassEventArgsToCommand="True"
                                Command="{Binding OnBorderMouseDownCommand}" />
    </dxmvvm:Interaction.Behaviors>
    <Canvas Name="svgContainer" MinHeight="300" />
</Border>
```

```csharp
public ICommand OnBorderMouseDownCommand { get; }

ctor()
{
    OnBorderMouseDownCommand   = new DelegateCommand<MouseButtonEventArgs>( OnBorderMouseDownCommandExecute );
}

private void OnBorderMouseDownCommandExecute( MouseButtonEventArgs e )
{
    // ...
}
```