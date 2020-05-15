# [ParentViewModel](https://documentation.devexpress.com/WPF/17449/MVVM-Framework/View-Models/ViewModel-relationships-ISupportParentViewModel)

- 一般而言，不應該從 ChildViewModel 來取出 ParentViewModel，因為這樣做會讓 ViewModel 的耦合性變的更高。

    > 如果需要這樣做的時候，請先思考 UserControl 的目的為何 !

- 將 MainView DataContext Inject 至 ChildView.ParentViewModel 時，會一併把 MainView 內 Interaction.Behaviors 所指定的 Service 對象一併 Inject 至 ChileView 中。雖然如此，但仍建議 ChildView 依然要給定 Interaction.Behaviors，這樣做會比較明確。

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
    mc:Ignorable="d" d:DesignHeight="500" d:DesignWidth="600">
    <UserControl.DataContext>
        <ViewModel:MainViewModel/>
    </UserControl.DataContext>
    <dxmvvm:Interaction.Behaviors>
        <dx:DXMessageBoxService/>
        <dxmvvm:CurrentWindowService />
    </dxmvvm:Interaction.Behaviors>

    <Grid x:Name="LayoutRoot" Background="White">
        <StackPanel Orientation="Vertical">
            <StackPanel Orientation="Horizontal">
                <TextBlock Text="MainView: "/>
                <Button Content="Show Message" Command="{Binding ShowMessageCommand}"/>
            </StackPanel>
            <StackPanel Orientation="Horizontal">
                <TextBlock Text="ChildView: " />
                <!-- 這邊定義如何 Binding ChildView 的 DataContext -->
                <View:ChildView dxmvvm:ViewModelExtensions.ParentViewModel="{Binding DataContext, ElementName=LayoutRoot}" />
            </StackPanel>
        </StackPanel>
    </Grid>
</UserControl>

```

```csharp
using DevExpress.Mvvm;
using System.Windows.Input;

namespace Example.ViewModel {
    public class ChildViewModel : ViewModelBase {
        public ICommand ShowMessageCommand { get; private set; }
        public ChildViewModel() {
            ShowMessageCommand = new DelegateCommand(ShowMessage);
        }

        IMessageBoxService MessageBoxService { get { return GetService<IMessageBoxService>(ServiceSearchMode.PreferParents); } }
        void ShowMessage() {

            // 這邊是如何從 ChildViewModel 取出 ParentViewModel 的語法
            var test = ((this as ISupportParentViewModel)?.ParentViewModel as MainViewModel)?.Test ?? string.Empty;

            MessageBoxService.Show("This is ChildView");
        }
    }
}

```

參考資料

- https://documentation.devexpress.com/WPF/17415/MVVM-Framework/Services/Predefined-Set/Message-Box-Services/DXMessageBoxService
