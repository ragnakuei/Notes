# EventArgsConverter

- [EventArgsConverter](#eventargsconverter)
  - [Button](#button)
  - [CustomButton](#custombutton)
  - [ListBox](#listbox)

---

當需要把參數從 UI 傳至 Command<T> 時

因為 EventToCommand 的參數是 EventArgs

而 Command<T> 可能是某個 Model

這時就會需要透過 EventArgsConverter 進行轉換

結論：

1. 當給定 CommandParameter 時，EventArgsConverter 就不會執行
1. CommandTarget 目前測試沒有功用

---

## Button

1. 當給定 CommandParameter 時，EventArgsConverter 就不會執行
1. CommandTarget 目前測試沒有功用

- ViewModel

```xml
<Button Content="Click"
        Grid.Row="2"
        CommandParameter="Test">
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:EventToCommand EventName="Click"
                                PassEventArgsToCommand="True"
                                Command="{Binding ClickBtnCommand}">
            <dxmvvm:EventToCommand.EventArgsConverter>
                <Common:ButtonEventArgsConverter />
            </dxmvvm:EventToCommand.EventArgsConverter>
        </dxmvvm:EventToCommand>
    </dxmvvm:Interaction.Behaviors>
</Button>
```

- View

```c#
public class ButtonEventArgsConverter : EventArgsConverterBase<RoutedEventArgs>
{
    protected override object Convert(object sender, RoutedEventArgs argsObj)
    {
        return new
        {
            Id = 1,
            Name = "A"
        };
    }
}

puoblic class ViewModel : ViewBase
{
    public void ClickBtn(dynamic data)
    {
        MessageBoxService.Show($"Id:{data?.Id} Name:{data?.Name}");
    }
}
```

---

## CustomButton

延續 [Button](##Button) 的範例，增加一些自訂的 Property

- CustomButton

    ```c#
    public class CustomButton : Button
    {
        public int CustomParameterInt { get; set; }
        public string CustomParameterString { get; set; }
    }
    ```

- View

    ```xml
    <ViewModel:CustomButton
            Content="Click"
            Grid.Row="2"
            CustomParameterInt="1"
            CustomParameterString="A">
        <dxmvvm:Interaction.Behaviors>
            <dxmvvm:EventToCommand EventName="Click"
                                    PassEventArgsToCommand="True"
                                    CommandTarget="{Binding ElementName=list}"
                                    Command="{Binding ClickBtnCommand}">
                <dxmvvm:EventToCommand.EventArgsConverter>
                    <Common:ButtonEventArgsConverter />
                </dxmvvm:EventToCommand.EventArgsConverter>
            </dxmvvm:EventToCommand>
        </dxmvvm:Interaction.Behaviors>
    </ViewModel:CustomButton>
    ```

- ViewModel

    ```c#
    public class ButtonEventArgsConverter : EventArgsConverterBase<RoutedEventArgs>
    {
        protected override object Convert(object sender, RoutedEventArgs argsObj)
        {
            var button = sender as CustomButton;

            return new
            {
                Id = button.CustomParameterInt,
                Name = button.CustomParameterString
            };
        }
    }
    ```

---

## ListBox

- ViewModel

  ```csharp
  public class MainViewModel : ViewModelBase
  {
      public MainViewModel()
      {
          Persons = new[]
          {
              new Person { Name = "A" },
              new Person { Name = "B" },
              new Person { Name = "C" },
          };

          EditCommand = new DelegateCommand<Person>(EditExecute, EditCanExecute);
      }

      public Person[] Persons { get; set; }

      public ICommand<Person> EditCommand { get; private set; }

      public void EditExecute(Person person)
      {
          MessageBox.Show("Success");
      }
      public bool EditCanExecute(Person person)
      {
          return person != null;
      }
  }

  public class Person
  {
      public string Name { get; set; }
  }
  ```

- View

  ```xml
  <Window x:Class="WpfApp6.MainWindow"
          xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
          xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
          xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
          xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
          xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
          xmlns:local="clr-namespace:WpfApp6"
          mc:Ignorable="d"
          Title="MainWindow" Height="450" Width="800">
      <Window.DataContext>
          <local:MainViewModel />
      </Window.DataContext>
      <StackPanel>
          <ListBox ItemsSource="{Binding Persons}">
              <dxmvvm:Interaction.Behaviors>
                  <dxmvvm:EventToCommand EventName="MouseDoubleClick" Command="{Binding EditCommand}">
                      <dxmvvm:EventToCommand.EventArgsConverter>
                          <!-- 在這裡指定 EventArgsConverter -->
                          <local:ListBoxEventArgsToPersonConverter />
                      </dxmvvm:EventToCommand.EventArgsConverter>
                  </dxmvvm:EventToCommand>
              </dxmvvm:Interaction.Behaviors>
              <ListBox.ItemTemplate>
                  <DataTemplate>
                      <Label Content="{Binding Name}"/>
                  </DataTemplate>
              </ListBox.ItemTemplate>
          </ListBox>
      </StackPanel>
  </Window>
  ```

- EventArgsConverter 的實作

  ```csharp
  public class ListBoxEventArgsToPersonConverter : EventArgsConverterBase<MouseEventArgs>
  {
      protected override object Convert(object sender, MouseEventArgs args)
      {
          // 取出被選擇的 Object 的幾個方式
          // var person = (sender as ListBox).SelectedItem as Person;
          // var person = (sender as ListBox).SelectedValue as Person;
          // var person = (args.OriginalSource as DXBorder)?.DataContext as Person;

          var parentElement = sender as ListBox;
          var clickedElement = args.OriginalSource as DependencyObject;

          var clickedListBoxItem = LayoutTreeHelper.GetVisualParents(child: clickedElement, stopNode: parentElement)
                                                              .OfType<ListBoxItem>()
                                                              .FirstOrDefault();
          var person = clickedListBoxItem?.DataContext as Person;

          return person;
      }
  }
  ```
