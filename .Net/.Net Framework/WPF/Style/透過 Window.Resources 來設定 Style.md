# 透過 Window.Resources 來設定 Style

- 以 TargetType 來指定要套用的控制項

```xml
<Window x:Class="WpfApp3.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp3"
        xmlns:dx="http://schemas.devexpress.com/winfx/2008/xaml/core"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Window.Resources>
        <Style TargetType="TextBlock">
            <Setter Property="FontSize" Value="16"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="DockPanel.Dock" Value="Top"/>
            <Setter Property="HorizontalAlignment" Value="Center"/>
        </Style>
        <Style TargetType="Canvas">
            <Setter Property="Height" Value="50"/>
            <Setter Property="Width" Value="50"/>
            <Setter Property="Margin" Value="8"/>
            <Setter Property="DockPanel.Dock" Value="Top"/>
        </Style>
        <Style TargetType="ComboBox">
            <Setter Property="Width" Value="150"/>
            <Setter Property="Margin" Value="8"/>
            <Setter Property="DockPanel.Dock" Value="Top"/>
        </Style>
    </Window.Resources>
    <Border Margin="10" BorderBrush="Silver" BorderThickness="3" Padding="8">
        <DockPanel>
            <TextBlock>Choose a Color:</TextBlock>
            <ComboBox Name="myComboBox" SelectedIndex="0">
                <ComboBoxItem>Green</ComboBoxItem>
                <ComboBoxItem>Blue</ComboBoxItem>
                <ComboBoxItem>Red</ComboBoxItem>
            </ComboBox>
            <Canvas>
                <Canvas.Background>
                    <Binding ElementName="myComboBox" Path="SelectedItem.Content"/>
                </Canvas.Background>
            </Canvas>
        </DockPanel>
    </Border>
</Window>

```
