# CustomBehaviorSample

安裝套件

> 因為 System.Windows.Interactivity 這個套件好像會有問題

> 請安裝 Expression.Blend.Sdk 套件

[程式碼](https://github.com/ragnakuei/WpfSample01/tree/master/WpfApp3/F)

- 在 Canvas 加上 取得 滑鼠座標的 Behavior
- 以 OneWayToSource 的方式 Binding 回 ViewModel
- 在從 ViewModel 透過 SetProperty 將值更新至 View 的 Label 中

```xml
<Window x:Class="WpfApp3.F.FView"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:local="clr-namespace:WpfApp3.F"
        xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
        xmlns:i="http://schemas.microsoft.com/expression/2010/interactivity"

        mc:Ignorable="d"
        Title="FView" Height="450" Width="800">
    <Window.DataContext>
        <local:FViewModel />
    </Window.DataContext>
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:CurrentWindowService />
        <dxmvvm:EventToCommand EventName="Loaded" Command="{Binding OnLoadedCommand}" />
    </dxmvvm:Interaction.Behaviors>
    <Canvas Margin="50,50,50,50" Background="Azure">
        <!-- 指定 Canvas 的 Custom Behavior -->
        <i:Interaction.Behaviors>
            <local:MouseBehaviour
                MouseX="{Binding AxisX,Mode=OneWayToSource}"
                MouseY="{Binding AxisY,Mode=OneWayToSource}" />
        </i:Interaction.Behaviors>

        <Label Content="MouseX" />
        <Label Content="{Binding AxisX}" Canvas.Left="68" />
        <Label Content="MouseY" Canvas.Top="21" />
        <Label Content="{Binding AxisY}" Canvas.Left="68" Canvas.Top="21" />
    </Canvas>
</Window>
```

Behavior

```csharp
/// <summary>
/// 用於抓取滑鼠座標
/// </summary>
public class MouseBehaviour : Behavior<Canvas>
{
    public static readonly DependencyProperty MouseYProperty
        = DependencyProperty.Register("MouseY"
                                    , typeof(double)
                                    , typeof(MouseBehaviour)
                                    , new PropertyMetadata(default(double)));

    public static readonly DependencyProperty MouseXProperty
        = DependencyProperty.Register("MouseX"
                                    , typeof(double)
                                    , typeof(MouseBehaviour)
                                    , new PropertyMetadata(default(double)));

    public double MouseY
    {
        get
        {
            return (double)GetValue(MouseYProperty);
        }
        set
        {
            SetValue(MouseYProperty, value);
        }
    }

    public double MouseX
    {
        get
        {
            return (double)GetValue(MouseXProperty);
        }
        set
        {
            SetValue(MouseXProperty, value);
        }
    }

    protected override void OnAttached()
    {
        AssociatedObject.MouseMove += AssociatedObjectOnMouseMove;
    }

    private void AssociatedObjectOnMouseMove(object sender, MouseEventArgs mouseEventArgs)
    {
        var pos = mouseEventArgs.GetPosition(AssociatedObject);
        MouseX = pos.X;
        MouseY = pos.Y;
    }

    protected override void OnDetaching()
    {
        AssociatedObject.MouseMove -= AssociatedObjectOnMouseMove;
    }
}

```

ViewModel

```csharp
public class FViewModel : ViewModelBase
{
    public FViewModel()
    {
        OnLoadedCommand = new DelegateCommand(OnLoadedCommandExecute, OnLoadedCommandCanEnable);
    }

    private double _axisX;
    public double AxisX
    {
        get => _axisX;
        set => SetProperty<double>(ref _axisX, value, nameof(AxisX));
    }

    private double _axisY;
    public double AxisY
    {
        get => _axisY;
        set => SetProperty<double>(ref _axisY, value, nameof(AxisY));
    }
}

```

參考資料

- [WPF Interaction框架簡介（一）——Behavior](https://www.itread01.com/content/1541605216.html)
- [WPF之Behavior](https://www.cnblogs.com/ListenFly/p/3275289.html)