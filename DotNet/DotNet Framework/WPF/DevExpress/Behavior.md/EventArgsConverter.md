# EventArgsConverter

當需要把參數從 UI 傳至 Command<T> 時

因為 EventToCommand 的參數是 EventArgs

而 Command<T> 可能是某個 Model

這時就會需要透過 EventArgsConverter 進行轉換

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
