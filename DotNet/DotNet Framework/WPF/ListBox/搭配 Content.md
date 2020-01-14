# 搭配 ContentControl

[How to: Bind to a Collection and Display Information Based on Selection](https://docs.microsoft.com/en-us/dotnet/framework/wpf/data/how-to-bind-to-a-collection-and-display-information-based-on-selection)

- ContentControl 會視 ListBox.IsSynchronizedWithCurrentItem 所設定的值來決定是否會同步顯示所選擇的項目

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
