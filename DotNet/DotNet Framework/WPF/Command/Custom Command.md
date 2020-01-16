# Custom Command

## 範例

從 [cut_paste](./cut_paste.md) 修改而來

新增 CustomCommands

```csharp
public static class CustomCommands
{
    public static readonly RoutedUICommand Cut = new RoutedUICommand();
    public static readonly RoutedUICommand Paste = new RoutedUICommand();
}
```

CommandBinding 內的 Command 分別指定 CustomCommands.Cut 及 CustomCommands.Paste，以及對應 Execute、CanExecute 動作

```xml
<Window x:Class="WpfApp15.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp15"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.DataContext>
        <local:MainViewModel />
    </Window.DataContext>
    <Window.CommandBindings>
        <CommandBinding Command="local:CustomCommands.Cut"
                        CanExecute="CutCommand_CanExecute"
                        Executed="CutCommand_Executed" />
        <CommandBinding Command="local:CustomCommands.Paste"
                        CanExecute="PasteCommand_CanExecute"
                        Executed="PasteCommand_Executed" />
    </Window.CommandBindings>
    <StackPanel Margin="15">
        <WrapPanel DockPanel.Dock="Top" Margin="3">
            <Button Command="local:CustomCommands.Cut" Width="Auto">_Cut</Button>
            <Button Command="local:CustomCommands.Paste" Width="Auto" Margin="3,0">_Paste</Button>
        </WrapPanel>
        <TextBox AcceptsReturn="True" Name="txtEditor" />
    </StackPanel>
</Window>
```

```csharp
public partial class MainWindow : Window
{
    public MainWindow()
    {
        InitializeComponent();
    }

    private void CloseCommandHandler(object sender, ExecutedRoutedEventArgs e)
    {
        this.Close();
    }

    private void NewCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e)
    {
        e.CanExecute = true;
    }

    private void NewCommand_Executed(object sender, ExecutedRoutedEventArgs e)
    {
        MessageBox.Show("The New command was invoked");
    }

    private void CutCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e)
    {
        e.CanExecute = (txtEditor != null) && (txtEditor.SelectionLength > 0);
    }

    private void CutCommand_Executed(object sender, ExecutedRoutedEventArgs e)
    {
        txtEditor.Cut();
    }

    private void PasteCommand_CanExecute(object sender, CanExecuteRoutedEventArgs e)
    {
        e.CanExecute = Clipboard.ContainsText();
    }

    private void PasteCommand_Executed(object sender, ExecutedRoutedEventArgs e)
    {
        txtEditor.Paste();
    }
}
```
