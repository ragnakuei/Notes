# Model Binding

- [Model Binding](#model-binding)
  - [範例一](#%e7%af%84%e4%be%8b%e4%b8%80)
    - [View](#view)
    - [BaseCommand](#basecommand)
    - [ViewModel](#viewmodel)

---

透過實作 INotifyPropertyChanged 來達成 Model Binding

## 範例一

以下 Property 都有 Model Binding 的功能

- 集合 - INotifyPropertyChanged 的實作要放在 `集合元素` 中
  - Users
- 單一值 - INotifyPropertyChanged 的實作要放在 `ViewModel` 中
  - SelectedUser
  - SelectedUserIndex

### View

ListView 同步至 ContentControl 可以參考[這裡](../ListView/搭配%20ContentControl.md#範例一)

```xml
<Window x:Class="WpfApp13.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp13"
        xmlns:i="http://schemas.microsoft.com/expression/2010/interactivity"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.DataContext>
        <local:MainWindowViewModel />
    </Window.DataContext>
    <i:Interaction.Triggers>
        <i:EventTrigger EventName="Loaded">
            <i:InvokeCommandAction Command="{Binding WindowOnLoadCommand}"/>
        </i:EventTrigger>
    </i:Interaction.Triggers>
    <Window.Resources>
        <DataTemplate x:Key="DetailTemplate">
            <Border BorderBrush="Black"
                    BorderThickness="1"
                    Padding="8"
                    Margin="20">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition />
                        <RowDefinition />
                    </Grid.RowDefinitions>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition />
                        <ColumnDefinition />
                    </Grid.ColumnDefinitions>
                    <TextBlock Grid.Row="0" Grid.Column="0" Text="First Name:" />
                    <TextBox Grid.Row="0" Grid.Column="1" Text="{Binding Path=FirstName}" />
                    <TextBlock Grid.Row="1" Grid.Column="0" Text="Last Name:" />
                    <TextBox Grid.Row="1" Grid.Column="1" Text="{Binding Path=LastName}" />
                </Grid>
            </Border>
        </DataTemplate>
    </Window.Resources>
    <StackPanel>
        <Label Content="Users：" />
        <ListView ItemsSource="{Binding Users}"
                  IsSynchronizedWithCurrentItem="True"
                  SelectedItem="{Binding SelectedUser,Mode=TwoWay}"
                  SelectedIndex="{Binding SelectedUserIndex}">
            <ListView.ItemTemplate>
                <DataTemplate>
                    <StackPanel Orientation="Horizontal">
                        <TextBlock Text="{Binding LastName}" />
                        <TextBlock Text=" "
                                   HorizontalAlignment="Right" />
                        <TextBlock Text="{Binding FirstName}"
                                   HorizontalAlignment="Right" />
                    </StackPanel>
                </DataTemplate>
            </ListView.ItemTemplate>
        </ListView>
        <Label Content="Selected User：" />
        <ContentControl Content="{Binding Users}" ContentTemplate="{StaticResource DetailTemplate}" />
        <Button Content="Confirm">
            <i:Interaction.Triggers>
                <i:EventTrigger EventName="Click">
                    <i:InvokeCommandAction Command="{Binding ConfirmOnClickCommand}"/>
                </i:EventTrigger>
            </i:Interaction.Triggers>
        </Button>
    </StackPanel>
</Window>
```

### BaseCommand

說明可參考[這裡](../EventToCommand.md##BaseCommand)

```csharp
public class BaseCommand : ICommand
{
    private readonly Action _execute;
    private readonly Func<bool> _canExecute;

    public BaseCommand(Action execute)
    {
        _execute = execute;
        _canExecute = () => true;
    }

    public BaseCommand(Action execute, Func<bool> canExecute)
    {
        _execute = execute;
        _canExecute = canExecute;
    }

    public bool CanExecute(object parameter)
    {
        return _canExecute.Invoke();
    }

    public void Execute(object parameter)
    {
        _execute.Invoke();
    }

    public event EventHandler CanExecuteChanged
    {
        add => CommandManager.RequerySuggested += value;
        remove => CommandManager.RequerySuggested -= value;
    }
}
```

### ViewModel

```csharp
public class MainWindowViewModel : INotifyPropertyChanged
{
    public MainWindowViewModel()
    {
        Users = new List<User>
                {
                    new User
                    {
                        FirstName = "Raj",
                        LastName = "Beniwal"
                    },
                    new User
                    {
                        FirstName = "Mark",
                        LastName = "henry"
                    },
                    new User
                    {
                        FirstName = "Mahesh",
                        LastName = "Chand"
                    },
                    new User
                    {
                        FirstName = "Vikash",
                        LastName = "Nanda"
                    },
                    new User
                    {
                        FirstName = "Harsh",
                        LastName = "Kumar"
                    },
                    new User
                    {
                        FirstName = "Reetesh",
                        LastName = "Tomar"
                    },
                    new User
                    {
                        FirstName = "Deven",
                        LastName = "Verma"
                    },
                    new User
                    {
                        FirstName = "Ravi",
                        LastName = "Taneja"
                    }
                }
            ;

        WindowOnLoadCommand = new MainWindowViewModelOnLoadCommand(OnLoadExecute);
        ConfirmOnClickCommand = new ConfirmClickCommand(ConfirmOnClickExecute);
    }

    private void ConfirmOnClickExecute()
    {
    }

    private void OnLoadExecute()
    {
        SelectedUser = null;
        SelectedUserIndex = -1;
    }


    public List<User> Users { get; }

    #region Command

    public ICommand WindowOnLoadCommand { get; set; }
    public ICommand ConfirmOnClickCommand { get; set; }

    private class MainWindowViewModelOnLoadCommand : BaseCommand
    {
        public MainWindowViewModelOnLoadCommand(Action execute)
            : base(execute)
        {
        }

        public MainWindowViewModelOnLoadCommand(Action execute, Func<bool> canExecute)
            : base(execute, canExecute)
        {
        }
    }

    private class ConfirmClickCommand : BaseCommand
    {
        public ConfirmClickCommand(Action execute)
            : base(execute)
        {
        }

        public ConfirmClickCommand(Action execute, Func<bool> canExecute)
            : base(execute, canExecute)
        {
        }
    }

    #endregion

    #region INotifyPropertyChanged Members

    private int _selectedUserIndex;
    private User _selectedUser;

    public User SelectedUser
    {
        get => _selectedUser;
        set
        {
            _selectedUser = value;
            OnPropertyChanged("SelectedUser");
        }
    }

    public int SelectedUserIndex
    {
        get => _selectedUserIndex;
        set
        {
            _selectedUserIndex = value;
            OnPropertyChanged("SelectedUserIndex");
        }
    }

    public event PropertyChangedEventHandler PropertyChanged;

    private void OnPropertyChanged(string propertyName)
    {
        if (PropertyChanged != null)
        {
            PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
        }
    }

    #endregion
}

public class User : INotifyPropertyChanged
{
    private string _firstName;
    private string _lastName;

    public string FirstName
    {
        get
        {
            return _firstName;
        }
        set
        {
            _firstName = value;
            OnPropertyChanged("FirstName");
        }
    }
    public string LastName
    {
        get
        {
            return _lastName;
        }
        set
        {
            _lastName = value;
            OnPropertyChanged("LastName");
        }
    }

    #region INotifyPropertyChanged Members

    public event PropertyChangedEventHandler PropertyChanged;
    private void OnPropertyChanged(string propertyName)
    {
        if (PropertyChanged != null)
        {
            PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
        }
    }
    #endregion

}
```
