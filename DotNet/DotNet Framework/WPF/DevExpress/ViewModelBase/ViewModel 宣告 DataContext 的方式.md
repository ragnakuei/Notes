# ViewModel

以下二種語法功能相同

1. 使用 DataContext Attribute

   ```xml
   <UserControl x:Class="Example.View.MainView"
       xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
       xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
       xmlns:ViewModel="clr-namespace:Example.ViewModel"
       xmlns:View="clr-namespace:Example.View"
       xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
       xmlns:dx="http://schemas.devexpress.com/winfx/2008/xaml/core"
       xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
       xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
       mc:Ignorable="d" d:DesignHeight="500" d:DesignWidth="600"
       DataContext="{dxmvvm:ViewModelSource ViewModel:MainViewModel}"
       >
   </UserControl>
   ```

1. 使用 UserControl.DataContext Tag

   ```xml
   <UserControl x:Class="Example.View.MainView"
       xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
       xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
       xmlns:ViewModel="clr-namespace:Example.ViewModel"
       xmlns:View="clr-namespace:Example.View"
       xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
       xmlns:dx="http://schemas.devexpress.com/winfx/2008/xaml/core"
       xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
       xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
       mc:Ignorable="d" d:DesignHeight="500" d:DesignWidth="600"
       >
       <UserControl.DataContext>
           <ViewModel:MainViewModel />
       </UserControl.DataContext>
   </UserControl>
   ```
