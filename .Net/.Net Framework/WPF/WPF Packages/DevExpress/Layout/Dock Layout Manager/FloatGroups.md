# FloatGroups

用來存放 FloatGroup 的集合

DockLayoutManager.FloatGroups 與 LayoutGroup 可以並存，不會互相影響 !

## 範例

[How to create floating panels in XAML](https://docs.devexpress.com/WPF/6837/controls-and-libraries/layout-management/dock-windows/examples/dock-functionality/how-to-create-floating-panels-in-xaml)

```xml
<Window
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApplication22"
        xmlns:dxdo="http://schemas.devexpress.com/winfx/2008/xaml/docking" x:Class="WpfApplication22.MainWindow"
        mc:Ignorable="d"
        Title="MainWindow" Height="350" Width="525">
    <Grid>
        <dxdo:DockLayoutManager x:Name="WindowDlm"  local:DualDlmMenuHelper.OppositeManager="{Binding ElementName=DesktopDlm}" FloatingMode="Desktop" >
            <dxdo:DockLayoutManager.FloatGroups>
                <!--Create a FloatGroup containing two panels-->
                <dxdo:FloatGroup FloatSize="400,200" FloatLocation="20,30">
                    <dxdo:LayoutPanel x:Name="paneProperties" Caption="Properties">
                        <RichTextBox />
                    </dxdo:LayoutPanel>
                    <dxdo:LayoutPanel x:Name="paneMessages" Caption="Messages">
                        <RichTextBox />
                    </dxdo:LayoutPanel>
                </dxdo:FloatGroup>
                <!--Create a FloatGroup containing one panel-->
                <dxdo:FloatGroup FloatSize="200,150" FloatLocation="100,100">
                    <dxdo:LayoutPanel x:Name="paneFindResults" Caption="Find Results">
                        <RichTextBox />
                    </dxdo:LayoutPanel>
                </dxdo:FloatGroup>
            </dxdo:DockLayoutManager.FloatGroups>
        </dxdo:DockLayoutManager>
        <dxdo:DockLayoutManager VerticalAlignment="Top" IsHitTestVisible="False" HorizontalAlignment="Left" Width="0" Height="0" x:Name="DesktopDlm" FloatingMode="Desktop" local:DualDlmMenuHelper.OppositeManager="{Binding ElementName=WindowDlm}">
        </dxdo:DockLayoutManager>
    </Grid>
</Window>
```
