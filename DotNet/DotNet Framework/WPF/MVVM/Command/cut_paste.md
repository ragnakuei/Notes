# cut_paste

- 剪下
  - 當 TextBox 內有選取文字時，此按鈕才會 Enable
- 貼上
  - 當 剪貼簿 內有文字時，此按鈕才會 Enable

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
        <CommandBinding Command="ApplicationCommands.Cut"
                        CanExecute="CutCommand_CanExecute"
                        Executed="CutCommand_Executed" />
        <CommandBinding Command="ApplicationCommands.Paste"
                        CanExecute="PasteCommand_CanExecute"
                        Executed="PasteCommand_Executed" />
    </Window.CommandBindings>
    <StackPanel Margin="15">
        <WrapPanel DockPanel.Dock="Top" Margin="3">
            <Button Command="ApplicationCommands.Cut" Width="Auto">_Cut</Button>
            <Button Command="ApplicationCommands.Paste" Width="Auto" Margin="3,0">_Paste</Button>
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
