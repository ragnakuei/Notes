# DataContext

- [DataContext](#datacontext)
  - [給定方式](#%e7%b5%a6%e5%ae%9a%e6%96%b9%e5%bc%8f)

---

## 給定方式

```csharp
<Window x:Class="WpfApp1.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:local="clr-namespace:WpfApp1"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.DataContext>
        <local:MainWindowViewModel />
    </Window.DataContext>
</Window>
```
