# [Binding](https://docs.microsoft.com/en-us/dotnet/api/system.windows.data.binding)

- [Binding](#binding)
  - [Simple Binding](#simple-binding)
  - [將 View 內的某控制項的值綁定到另一個控制項中](#%e5%b0%87-view-%e5%85%a7%e7%9a%84%e6%9f%90%e6%8e%a7%e5%88%b6%e9%a0%85%e7%9a%84%e5%80%bc%e7%b6%81%e5%ae%9a%e5%88%b0%e5%8f%a6%e4%b8%80%e5%80%8b%e6%8e%a7%e5%88%b6%e9%a0%85%e4%b8%ad)
  - [ObservableCollection Binding](#observablecollection-binding)
  - [Composite Collection](#composite-collection)

---

- [Data binding how-to topics](https://docs.microsoft.com/en-us/dotnet/framework/wpf/data/data-binding-how-to-topics)

- [如何：指定系結的方向](https://docs.microsoft.com/zh-tw/dotnet/framework/wpf/data/how-to-specify-the-direction-of-the-binding)

---

## Simple Binding

- 於 Resource 中，直接宣告物件的資料
- Binding Source StaticResource 後面接的是 Window.Resource Key
- Binding Source Path 指的是物件的 Property

```csharp
public class Person
{
    public string PersonName { get; set; }
}
```

```xml
<Window x:Class="WpfApp3.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
        xmlns:local="clr-namespace:WpfApp3"
        xmlns:dx="http://schemas.devexpress.com/winfx/2008/xaml/core"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.Resources>
        <local:Person x:Key="myDataSource" PersonName="Joe"/>
    </Window.Resources>>
    <StackPanel>
        <TextBlock Text="{Binding Source={StaticResource myDataSource}, Path=PersonName}"/>
    </StackPanel>
</Window>
```

---

## 將 View 內的某控制項的值綁定到另一個控制項中

```xml
<TextBox Name="TextBox1"></TextBox>
<subUserControl:ESubUserControl1
                UserName="{Binding Path=Text, ElementName=TextBox1, Mode=OneWay}" />
```

---

## ObservableCollection Binding

```xml
<Window x:Class="WpfApp3.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
        xmlns:local="clr-namespace:WpfApp3"
        xmlns:dx="http://schemas.devexpress.com/winfx/2008/xaml/core"
        xmlns:system="clr-namespace:System;assembly=mscorlib"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.DataContext>
        <local:MainViewModel />
    </Window.DataContext>
    <Window.Resources>
        <!-- People 就是 ObservableCollection<Person> -->
        <local:People x:Key="MyFriends" >
            <local:Person FirstName="FirstA" LastName="LastA" HomeTown="TownA" />
            <local:Person FirstName="FirstB" LastName="LastB" HomeTown="TownB" />
            <local:Person FirstName="FirstC" LastName="LastC" HomeTown="TownC" />
        </local:People>
        <DataTemplate x:Key="DetailTemplate">
            <Border Width="300" Height="100" Margin="20" BorderBrush="Aqua" BorderThickness="1" Padding="8">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition/>
                        <RowDefinition/>
                        <RowDefinition/>
                    </Grid.RowDefinitions>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition/>
                        <ColumnDefinition/>
                    </Grid.ColumnDefinitions>
                    <TextBlock Grid.Row="0" Grid.Column="0" Text="First Name:"/>
                    <TextBlock Grid.Row="0" Grid.Column="1" Text="{Binding Path=FirstName}"/>
                    <TextBlock Grid.Row="1" Grid.Column="0" Text="Last Name:"/>
                    <TextBlock Grid.Row="1" Grid.Column="1" Text="{Binding Path=LastName}"/>
                    <TextBlock Grid.Row="2" Grid.Column="0" Text="Home Town:"/>
                    <TextBlock Grid.Row="2" Grid.Column="1" Text="{Binding Path=HomeTown}"/>
                </Grid>
            </Border>
        </DataTemplate>
    </Window.Resources>
    <StackPanel>
        <TextBlock FontFamily="Verdana" FontSize="11" Margin="5,15,0,10" FontWeight="Bold">My Friends:</TextBlock>
        <ListBox Width="200" IsSynchronizedWithCurrentItem="True" ItemsSource="{Binding Source={StaticResource MyFriends}}"/>

        <TextBlock FontFamily="Verdana" FontSize="11" Margin="5,15,0,5" FontWeight="Bold">Information:</TextBlock>
        <ContentControl Content="{Binding Source={StaticResource MyFriends}}" ContentTemplate="{StaticResource DetailTemplate}" />
    </StackPanel>
</Window>
```

```csharp
public class People : ObservableCollection<Person>
{

}

public class Person
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string HomeTown { get; set; }

    // 為了讓 UI 的 ListBox 可以直接顯示 FirstName 清單
    public override string ToString()
    {
        return FirstName.ToString();
    }
}
```

---

Binding Enum

```xml
<Window x:Class="WpfApp3.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp3"
        xmlns:dx="http://schemas.devexpress.com/winfx/2008/xaml/core"
        xmlns:sys="clr-namespace:System;assembly=mscorlib"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.DataContext>
        <local:MainViewModel />
    </Window.DataContext>
    <Window.Resources>
        <!-- 這邊指定了使用 mscorlib 內的 System.Enum.GetValues() 來取值 -->
        <ObjectDataProvider MethodName="GetValues"
                        ObjectType="{x:Type sys:Enum}"
                        x:Key="AlignmentValues">
            <!-- 這邊指定了以 Type HorizontalAlignment 做為上述的參數 -->
            <ObjectDataProvider.MethodParameters>
                <x:Type TypeName="HorizontalAlignment" />
            </ObjectDataProvider.MethodParameters>
        </ObjectDataProvider>
    </Window.Resources>
    <StackPanel>
        <StackPanel Width="300">
            <TextBlock>Choose the HorizontalAlignment value of the Button:</TextBlock>
            <!-- 以 Key 值來做對應，從 Windows Resouces 中取出物件陣列來做為此 ListBox 的 Source -->
            <ListBox Name="myComboBox" SelectedIndex="0" Margin="8"
               ItemsSource="{Binding Source={StaticResource AlignmentValues}}"/>
            <!-- 當 ListBox 選定了其中一個項目後，就會直接套用至此 Button 上 -->
            <Button Content="Click Me!"
              HorizontalAlignment="{Binding ElementName=myComboBox,
                                            Path=SelectedItem}"/>
        </StackPanel>
    </StackPanel>
</Window>
```

---

## Composite Collection

複合式 Collection

```xml
<Window x:Class="WpfApp3.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp3"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">

    <Window.Resources>

        <!-- 第一種資料 -->
        <local:GreekGods x:Key="GreekGodsData">
            <local:GreekGod Name="GodA" />
            <local:GreekGod Name="GodB" />
            <local:GreekGod Name="GodC" />
        </local:GreekGods>

        <!-- 第二種資料 -->
        <XmlDataProvider x:Key="GreekHeroesData" XPath="GreekHeroes/Hero">
            <x:XData>
                <GreekHeroes xmlns="">
                    <Hero Name="Jason" />
                    <Hero Name="Hercules" />
                    <Hero Name="Bellerophon" />
                    <Hero Name="Theseus" />
                    <Hero Name="Odysseus" />
                    <Hero Name="Perseus" />
                </GreekHeroes>
            </x:XData>
        </XmlDataProvider>

        <!-- 以 Type 來給定不同的 DataTemplate -->
        <DataTemplate DataType="{x:Type local:GreekGod}">
            <TextBlock Text="{Binding Path=Name}" Foreground="Gold"/>
        </DataTemplate>

        <!-- 以 Type 來給定不同的 DataTemplate -->
        <DataTemplate DataType="Hero">
            <TextBlock Text="{Binding XPath=@Name}" Foreground="Cyan"/>
        </DataTemplate>
    </Window.Resources>

    <StackPanel>
        <TextBlock FontSize="18" FontWeight="Bold" Margin="10"
      HorizontalAlignment="Center">Composite Collections Sample</TextBlock>
        <ListBox Name="myListBox" Height="300" Width="200" Background="White">
            <ListBox.ItemsSource>
                <!-- 宣告會以不同的 Collection 來做為 DataSource -->
                <CompositeCollection>
                    <CollectionContainer
            Collection="{Binding Source={StaticResource GreekGodsData}}" />
                    <CollectionContainer
            Collection="{Binding Source={StaticResource GreekHeroesData}}" />
                    <ListBoxItem Foreground="Red">Other Listbox Item 1</ListBoxItem>
                    <ListBoxItem Foreground="Red">Other Listbox Item 2</ListBoxItem>
                </CompositeCollection>
            </ListBox.ItemsSource>
        </ListBox>
    </StackPanel>
</Window>
```

```csharp
public class GreekGods : ObservableCollection<GreekGod>
{

}

public class GreekGod
{
    public string Name { get; set; }
}

public class GreekHeroes : ObservableCollection<Hero>
{

}

public class Hero
{
    public string Name { get; set; }
}
```
