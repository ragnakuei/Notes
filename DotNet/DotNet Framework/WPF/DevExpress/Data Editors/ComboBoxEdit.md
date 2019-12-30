# [ComboBoxEdit](https://documentation.devexpress.com/WPF/6166/Controls-and-Libraries/Data-Editors/Editor-Types/ComboBoxEdit)

---

以 ComboBoxEdit 做為顯示資料的條件，在該條件下的資料，會顯示在下方的 GridControl 中

```xml
<UserControl
    x:Class="EnumItemsSourceBehaviorExample.View.MainView"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    xmlns:dxe="http://schemas.devexpress.com/winfx/2008/xaml/editors"
    xmlns:dxg="http://schemas.devexpress.com/winfx/2008/xaml/grid"
    xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
    xmlns:vm="clr-namespace:EnumItemsSourceBehaviorExample.ViewModel"
    xmlns:common="clr-namespace:EnumItemsSourceBehaviorExample.Common"
    mc:Ignorable="d" d:DesignHeight="300" d:DesignWidth="300"
    DataContext="{dxmvvm:ViewModelSource Type={x:Type vm:MainViewModel}}">
    <Grid Background="White">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition/>
        </Grid.RowDefinitions>
        <dxe:ComboBoxEdit Margin="10"
                          EditValue="{Binding SelectedRole, UpdateSourceTrigger=PropertyChanged, Mode=TwoWay}"
                          Name="comboBoxEdit"
                          IsTextEditable="False"
                          ApplyItemTemplateToSelectedItem="True">
            <dxmvvm:Interaction.Behaviors>
                <dxmvvm:EnumItemsSourceBehavior EnumType="{x:Type common:UserRole}" SortMode="DisplayName"/>
            </dxmvvm:Interaction.Behaviors>
            <dxe:ComboBoxEdit.ItemTemplate>
                <DataTemplate>
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition/>
                            <RowDefinition/>
                        </Grid.RowDefinitions>
                        <TextBlock Text="{Binding Name}"/>
                        <TextBlock Text="{Binding Description}" Grid.Row="1" FontSize="9"/>
                    </Grid>
                </DataTemplate>
            </dxe:ComboBoxEdit.ItemTemplate>
        </dxe:ComboBoxEdit>
        <Grid Grid.Row="1">
            <dxg:GridControl Margin="10"
                             ItemsSource="{Binding Users}"
                             AutoGenerateColumns="AddNew"
                             FilterString="{Binding Path=SelectedRole, Converter={common:FilterStringConverter}, ConverterParameter=Role}">
                <dxg:GridControl.Columns>
                    <dxg:GridColumn FieldName="Name"/>
                    <dxg:GridColumn FieldName="ID"/>
                    <dxg:GridColumn FieldName="Role">
                        <dxg:GridColumn.CellTemplate>
                            <DataTemplate>
                                <dxe:ComboBoxEdit Name="PART_Editor" IsTextEditable="False" ApplyItemTemplateToSelectedItem="True">
                                    <dxmvvm:Interaction.Behaviors>
                                        <dxmvvm:EnumItemsSourceBehavior EnumType="{x:Type common:UserRole}" />
                                    </dxmvvm:Interaction.Behaviors>
                                </dxe:ComboBoxEdit>
                            </DataTemplate>
                        </dxg:GridColumn.CellTemplate>
                    </dxg:GridColumn>
                </dxg:GridControl.Columns>
                <dxg:GridControl.View>
                    <dxg:TableView AllowEditing="False"
                                   ShowFilterPanelMode="Never"
                                   ShowColumnHeaders="False"
                                   ShowGroupPanel="False"
                                   VerticalScrollbarVisibility="Auto"
                                   NavigationStyle="Row"
                                   FadeSelectionOnLostFocus="False"/>
                </dxg:GridControl.View>
            </dxg:GridControl>
        </Grid>
    </Grid>
</UserControl>
```

```csharp
using System.Collections.ObjectModel;
using DevExpress.Mvvm.POCO;
using EnumItemsSourceBehaviorExample.Common;

namespace EnumItemsSourceBehaviorExample.ViewModel {
    public class MainViewModel {
        protected MainViewModel() {
            Users = new ObservableCollection<User>() {
                User.Create(0, "Jack", UserRole.Administrator),
                User.Create(1, "Ron", UserRole.User),
                User.Create(2, "John", UserRole.User),
                User.Create(3, "Antoni", UserRole.User),
                User.Create(4, "Paul", UserRole.Moderator),
            };
            SelectedRole = UserRole.User;
        }
        public static MainViewModel Create() {
            return ViewModelSource.Create(() => new MainViewModel());
        }

        public virtual ObservableCollection<User> Users { get; set; }
        public virtual UserRole SelectedRole { get; set; }
    }
}
```
