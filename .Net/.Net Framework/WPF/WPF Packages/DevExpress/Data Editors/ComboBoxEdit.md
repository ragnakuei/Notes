# [ComboBoxEdit](https://documentation.devexpress.com/WPF/6166/Controls-and-Libraries/Data-Editors/Editor-Types/ComboBoxEdit)

- [ComboBoxEdit](#comboboxedit)
  - [Properties](#properties)
  - [基本範例](#基本範例)
  - [Binding 做法](#binding-做法)
  - [套用 EnumItemsSourceBehavior.md 結合的 Sample](#套用-enumitemssourcebehaviormd-結合的-sample)
  - [Operation Mode](#operation-mode)
  - [highlight sample](#highlight-sample)
  - [搜尋功能](#搜尋功能)

---

## Properties

| Property             | 說明                                  |
| -------------------- | ------------------------------------- |
| ImmediatePopup       | 輸入值 / EditValueChange 是否要 Popup |
| IncrementalFiltering | 是否要動態篩選                        |
| FilterCondition      | 動態篩選比對模式                      |
|                      |                                       |

## 基本範例

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

## Binding 做法

```xml
<dxe:ComboBoxEdit
    DisplayMember="Name"
    ItemsSource="{Binding Tests}"
    SelectedItem="{Binding SelectedTest}"
    ValueMember="Id">
    <dxe:ComboBoxEdit.StyleSettings>
        <dxe:ComboBoxStyleSettings />
    </dxe:ComboBoxEdit.StyleSettings>
</dxe:ComboBoxEdit>
```

```csharp
public class TestViewModel : ViewModelBase
{
    public TestViewModel()
    {
        Tests = new ObservableCollection<Test>
        {
            new Test
            {
                Id = 1,
                Name = TestEnum.A,
            },
            new Test
            {
                Id = 2,
                Name = TestEnum.B,
            },
            new Test
            {
                Id = 3,
                Name = TestEnum.C,
            },
        };
    }

    public ObservableCollection<Test> Tests { get; set; }

    private Test _selectedTest;

    public Test SelectedTest
    {
        get {
            return selectedTest;
        }

        set {
            SetProperty(ref selectedTest, value, nameof(SelectedTest));
        }
    }
}

public class Test
{
    public int Id { get; set; }
    public TestEnum Name { get; set; }
}

public enum TestEnum
{
    None,
    A,
    B,
    C,
}
```

## 套用 [EnumItemsSourceBehavior.md](./Behavior.md/EnumItemsSourceBehavior.md) 結合的 Sample

-   可直接抓取 enum 的 attribute Image 及 Display
-   如果要搭配 GridControl 的 Filter Binding，要改為 使用 ViewModelSource 的方式給定 ViewModel

```xml
<Window x:Class="WpfSample01.Samples.K.KView"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:local="clr-namespace:WpfSample01.Samples.K"
        xmlns:dxe="http://schemas.devexpress.com/winfx/2008/xaml/editors"
        xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
        xmlns:dxg="http://schemas.devexpress.com/winfx/2008/xaml/grid"
        mc:Ignorable="d"
        DataContext="{dxmvvm:ViewModelSource Type={ x:Type local:KViewModel}}"
        Title="KView" Height="450" Width="800">
    <StackPanel>
        <dxe:ComboBoxEdit Margin="10"
                          EditValue="{Binding SelectedRole, UpdateSourceTrigger=PropertyChanged, Mode=TwoWay}"
                          Name="comboBoxEdit"
                          IsTextEditable="False"
                          ApplyItemTemplateToSelectedItem="True">
            <dxmvvm:Interaction.Behaviors>
                <dxmvvm:EnumItemsSourceBehavior EnumType="{x:Type local:UserRole}" SortMode="DisplayName" />
            </dxmvvm:Interaction.Behaviors>
            <dxe:ComboBoxEdit.ItemTemplate>
                <DataTemplate>
                    <Grid>
                        <Grid.RowDefinitions>
                            <RowDefinition />
                            <RowDefinition />
                        </Grid.RowDefinitions>
                        <TextBlock Text="{Binding Name}" />
                        <TextBlock Text="{Binding Description}" Grid.Row="1" FontSize="9" />
                    </Grid>
                </DataTemplate>
            </dxe:ComboBoxEdit.ItemTemplate>
        </dxe:ComboBoxEdit>
    </StackPanel>
</Window>
```

```csharp
    public class User {
        protected User(string name, int iD, UserRole role) {
            Name = name;
            ID = iD;
            Role = role;
        }
        public static User Create(int id, string name, UserRole role) {
            return ViewModelSource.Create(() => new User(name, id, role));
        }

        public string Name { get; set; }
        public int ID { get; set; }
        public UserRole Role { get; set; }
    }

    public enum UserRole {
        [Image("pack://application:,,,/Samples/K/Images/Admin.png"), Display(Name = "Admin", Description = "High level of access")]
        Administrator,
        [Image("pack://application:,,,/Samples/K/Images/Moderator.png"), Display(Name = "Moderator", Description = "Average level of access")]
        Moderator,
        [Image("pack://application:,,,/Samples/K/Images/User.png"), Display(Name = "User", Description = "Low level of access")]
        User
    }

    public class KViewModel
    {
        public KViewModel()
        {
            Users = new ObservableCollection<User>
                    {
                        User.Create(0, "Jack", UserRole.Administrator),
                        User.Create(1, "Ron", UserRole.User),
                        User.Create(2, "John", UserRole.User),
                        User.Create(3, "Antoni", UserRole.User),
                        User.Create(4, "Paul", UserRole.Moderator),
                    };

            SelectedRole = UserRole.User;

            CheckCommand = new DelegateCommand(CheckCommandExecute);
        }

        public static KViewModel Create() {
            return ViewModelSource.Create(() => new KViewModel());
        }

        public ICommand CheckCommand { get; private set; }

        private void CheckCommandExecute()
        {
            MessageBox.Show(SelectedRole.ToString());
        }

        public virtual ObservableCollection<User> Users { get; set; }
        public virtual UserRole SelectedRole { get; set; }
    }

    public class FilterStringConverterExtension : MarkupExtension {
        public override object ProvideValue(IServiceProvider serviceProvider) {
            return new FilterStringConverter();
        }
    }

    public class FilterStringConverter : IValueConverter
    {
        public object Convert(object value,
                              Type targetType,
                              object parameter,
                              System.Globalization.CultureInfo culture)
        {
            if (value == null) return Binding.DoNothing;
            return String.Format("[{0}] = '{1}'", parameter, value);
        }

        public object ConvertBack(object value,
                                  Type targetType,
                                  object parameter,
                                  System.Globalization.CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }

```

## [Operation Mode](https://docs.devexpress.com/WPF/116528/controls-and-libraries/data-editors/common-features/editor-operation-modes/comboboxedit)

```xml
<dxe:ComboBoxEdit ItemsSource="{Binding LookUpEditItemSource}">
    <dxe:ComboBoxEdit.StyleSettings>
        <!-- 指定 StyleSetting -->
        <dxe:ComboBoxStyleSettings />
    </dxe:ComboBoxEdit.StyleSettings>
</dxe:ComboBoxEdit>
```

## [highlight sample](https://supportcenter.devexpress.com/Ticket/Details/T351288/comboboxedit-with-editable-text-highlight-matches-in-combobox-items)

## 搜尋功能

要用搜尋功能時，無法使用 DisplayMember 及 ValueMember，但可以建立一備繼承 ComboBoxEditItem 的 class 來處理/替代 value 的部份 !

```csharp
ComboBoxEdit featureCombobox = new ComboBoxEdit
                                {
                                    Margin               = new Thickness(5, 5, 5, 5),
                                    Height               = 20,

                                    // 主要差在下面三個項目上
                                    IncrementalFiltering = true,
                                    FilterCondition      = FilterCondition.Contains,
                                    ImmediatePopup       = true,

                                    ItemsSource = FeatureStore.Features
                                                                .Select(f => new ComboBoxEditItemWithFeature
                                                                            {
                                                                                Content = f.Text,
                                                                                Feature = f.Feature
                                                                            }),
                                };
featureCombobox.SelectedIndexChanged += OnFeatureChanged;
```
