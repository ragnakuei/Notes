# [CompositeCommandBehavior](https://documentation.devexpress.com/WPF/18124/MVVM-Framework/Behaviors/Predefined-Set/CompositeCommandBehavior)

可依序執行多個 Command

```xml
<Window x:Class="WpfSample01.Samples.L.LView"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:local="clr-namespace:WpfSample01.Samples.L"
        xmlns:dxb="http://schemas.devexpress.com/winfx/2008/xaml/bars"
        xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
        mc:Ignorable="d"
        Title="LView" Height="450" Width="800">
    <Window.DataContext>
        <local:LViewModel />
    </Window.DataContext>
    <Grid>
        <dxb:BarManager>
            <dxb:BarManager.Bars>
                <dxb:Bar Caption="Main Menu" IsMainMenu="True">
                    <dxb:BarButtonItem Content="Save" Command="{Binding SaveCommand}"/>
                    <dxb:BarButtonItem Content="Close" Command="{Binding CloseCommand}"/>
                    <dxb:BarButtonItem Content="Save and Close">
                        <dxmvvm:Interaction.Behaviors>
                            <dxmvvm:CompositeCommandBehavior>
                                <dxmvvm:CommandItem Command="{Binding SaveCommand}"/>
                                <dxmvvm:CommandItem Command="{Binding CloseCommand}"/>
                            </dxmvvm:CompositeCommandBehavior>
                        </dxmvvm:Interaction.Behaviors>
                    </dxb:BarButtonItem>
                </dxb:Bar>
            </dxb:BarManager.Bars>
            <Grid>
                <TextBox Text="{Binding Text,Mode=TwoWay, UpdateSourceTrigger=PropertyChanged}" AcceptsReturn="True"/>
            </Grid>
        </dxb:BarManager>
    </Grid>
</Window>

```

```csharp
    public class LViewModel : ViewModelBase
    {
        public LViewModel()
        {
            SaveCommand = new DelegateCommand(SaveCommandExecute);
            CloseCommand = new DelegateCommand(CloseCommandExecute);
        }

        public ICommand SaveCommand { get; private set; }

        private void SaveCommandExecute()
        {
            Debug.WriteLine("Save");
        }

        public ICommand CloseCommand { get; private set; }

        private void CloseCommandExecute()
        {
            Debug.WriteLine("Close");
        }
    }
```
