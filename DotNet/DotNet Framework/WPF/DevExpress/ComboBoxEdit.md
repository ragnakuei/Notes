# [ComboBoxEdit](https://documentation.devexpress.com/WPF/6166/Controls-and-Libraries/Data-Editors/Editor-Types/ComboBoxEdit)

## 套用 [EnumItemsSourceBehavior.md](./Behavior.md/EnumItemsSourceBehavior.md) 結合的 Sample

- 可直接抓取 enum 的 attribute Image 及 Display
- 如果要搭配 GridControl 的 Filter Binding，要改為 使用 ViewModelSource 的方式給定 ViewModel

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
