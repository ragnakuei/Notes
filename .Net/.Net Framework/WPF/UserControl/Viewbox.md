# [Viewbox](https://docs.microsoft.com/zh-tw/dotnet/api/system.windows.controls.viewbox)

讓 Viewbox 內的物件，看起來可以自由縮放，但內容實際大小不變

## 範例一

先定義好內容的大小後，外框可不綁定大小，就可以直接以 Window 的大小進行動態縮放

```xml
<UserControl
    x:Class="UI.View.ImpedanceMapView"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:local="clr-namespace:UI.View"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:oxy="http://oxyplot.org/wpf"
    xmlns:viewModel="clr-namespace:UI.ViewModel"
    mc:Ignorable="d">
    <UserControl.DataContext>
        <viewModel:ImpedanceMapViewModel />
    </UserControl.DataContext>
    <Viewbox>
        <oxy:PlotView
            Width="600"
            Height="600"
            Model="{Binding PlotViewModel}" />
    </Viewbox>
</UserControl>
```


## Property

### [Stretch](https://docs.microsoft.com/zh-tw/dotnet/api/system.windows.media.stretch) 

預設值為 Uniform

### [StretchDirection](https://docs.microsoft.com/zh-tw/dotnet/api/system.windows.controls.stretchdirection)

預設值為 Both

