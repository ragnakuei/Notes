# ProgressBarEdit

[給定 ProgressBarEdit 範例](https://supportcenter.devexpress.com/ticket/details/q538214/wpf-ribbonstatusbarcontrol-progressbar)

## xaml + mvvm 範例

```xml
<dxr:DXRibbonWindow x:Class="Q421413.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
		xmlns:dxb="http://schemas.devexpress.com/winfx/2008/xaml/bars"
		xmlns:dxc="http://schemas.devexpress.com/winfx/2008/xaml/core"
        xmlns:dxe="http://schemas.devexpress.com/winfx/2008/xaml/editors"
		xmlns:dxr="http://schemas.devexpress.com/winfx/2008/xaml/ribbon"
		xmlns:dxrt="http://schemas.devexpress.com/winfx/2008/xaml/ribbon/themekeys"
        xmlns:dx="http://schemas.devexpress.com/winfx/2008/xaml/core"
        Title="MainWindow" Height="350" Width="700">
	<dxr:DXRibbonWindow.Resources>

	</dxr:DXRibbonWindow.Resources>
	<Grid>
		<dxb:BarManager Name="barManager1" >
			<dxb:BarManager.Items>

                <dxb:BarEditItem Name="BarEditItem" EditValue="50" EditWidth="100">
                    <dxb:BarEditItem.EditSettings>
                        <dxe:ProgressBarEditSettings Minimum="0" Maximum="100" ContentDisplayMode="Value"/>
                    </dxb:BarEditItem.EditSettings>
                </dxb:BarEditItem>

                <dxb:BarStaticItem Name="BarStaticItem" Content="50">
                    <dxb:BarStaticItem.ContentTemplate>
                        <DataTemplate>
                            <dxe:ProgressBarEdit Minimum="0" Maximum="100" Width="100" Value="{Binding}" ContentDisplayMode="Value"/>
                        </DataTemplate>
                    </dxb:BarStaticItem.ContentTemplate>
                </dxb:BarStaticItem>

			</dxb:BarManager.Items>
            <DockPanel>
                <dxr:RibbonControl Name="ribbonControl1" DockPanel.Dock="Top" RibbonStyle="Office2010">
                    <dxr:RibbonDefaultPageCategory Caption="defaultCategory" Name="ribbonDefaultPageCategory1">
                        <dxr:RibbonPage Caption="RibbonPage1" Name="ribbonPage1">

                        </dxr:RibbonPage>
                    </dxr:RibbonDefaultPageCategory>
                </dxr:RibbonControl>

                <dxr:RibbonStatusBarControl DockPanel.Dock="Bottom" Name="StatusBar" IsSizeGripVisible="True">
                    <dxr:RibbonStatusBarControl.LeftItemLinks>
                        <dxb:BarItemLink BarItemName="BarEditItem"/>
                        <dxb:BarItemLink BarItemName="BarStaticItem"/>
                    </dxr:RibbonStatusBarControl.LeftItemLinks>
                </dxr:RibbonStatusBarControl>
            </DockPanel>
        </dxb:BarManager>
	</Grid>
</dxr:DXRibbonWindow>
```

## 以 Code 方式設定 DataTemplate 的方式

與上述 Sample 不同

左方設定 `字串`

右方設定為 `ProgressBarEdit`

注意：手動給定 `DependencyProperty` 的值時，要注意型別是否一致。 int 與 double 會判斷為型別不相容 !

```xml
<dxr:RibbonStatusBarControl DockPanel.Dock="Bottom">
    <dxr:RibbonStatusBarControl.LeftItems>
        <dxb:BarStaticItem AutoSizeMode="Fill" Content="{Binding StatusBarLeftItem}" />
    </dxr:RibbonStatusBarControl.LeftItems>
    <dxr:RibbonStatusBarControl.RightItems >
        <dxb:BarStaticItem ContentTemplate="{Binding StatusBarRightItem}" />
    </dxr:RibbonStatusBarControl.RightItems>
</dxr:RibbonStatusBarControl>
```

```csharp
private string _statusBarLeftItem;

public string StatusBarLeftItem
{
    get => _statusBarLeftItem;
    set => SetProperty(ref _statusBarLeftItem, value, nameof(StatusBarLeftItem));
}

private DataTemplate _statusBarRightItem;

public DataTemplate StatusBarRightItem
{
    get => _statusBarRightItem;
    set => SetProperty(ref _statusBarRightItem, value, nameof(StatusBarRightItem));
}

public SetStatusBarItems()
{
    StatusBarLeftItem = "Ready";

    StatusBarRightItem = new DataTemplate(typeof(BarStaticItem));

    var progressBar = new FrameworkElementFactory(typeof(ProgressBarEdit));
    progressBar.SetValue(ProgressBarEdit.MinimumProperty,            (double)0);
    progressBar.SetValue(ProgressBarEdit.MaximumProperty,            (double)100);
    progressBar.SetValue(ProgressBarEdit.WidthProperty,              (double)100);
    progressBar.SetValue(ProgressBarEdit.ValueProperty,              (double)50);
    progressBar.SetValue(ProgressBarEdit.ContentDisplayModeProperty, ContentDisplayMode.Value);

    StatusBarRightItem.VisualTree = progressBar;
}
```
