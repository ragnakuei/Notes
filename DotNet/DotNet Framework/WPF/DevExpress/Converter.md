# Converter

- [Converter](#converter)
  - [透過 BooleanToObjectConverter 直接將 boolean 值轉換成要顯示的文字](#%e9%80%8f%e9%81%8e-booleantoobjectconverter-%e7%9b%b4%e6%8e%a5%e5%b0%87-boolean-%e5%80%bc%e8%bd%89%e6%8f%9b%e6%88%90%e8%a6%81%e9%a1%af%e7%a4%ba%e7%9a%84%e6%96%87%e5%ad%97)

---

## 透過 BooleanToObjectConverter 直接將 boolean 值轉換成要顯示的文字

```xml
<UserControl x:Class="WpfApp7.Main.MainView"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
             xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
             xmlns:local="clr-namespace:WpfApp7.Main"
             xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
             xmlns:dxe="http://schemas.devexpress.com/winfx/2008/xaml/editors"
             xmlns:child="clr-namespace:WpfApp7.Child"
             DataContext="{dxmvvm:ViewModelSource Type=local:MainViewModel}"
             Name="LayoutRoot"
             mc:Ignorable="d" >
    <UserControl.Resources>
        <dxmvvm:BooleanToObjectConverter x:Key="BooleanToObjectConverterKey" TrueValue="Saved!" FalseValue="Unsaved!"/>
    </UserControl.Resources>
    <StackPanel>
        <TextBlock Text="{Binding IsSaved, Converter={StaticResource BooleanToObjectConverterKey}}"/>
    </StackPanel>
</UserControl>
```
