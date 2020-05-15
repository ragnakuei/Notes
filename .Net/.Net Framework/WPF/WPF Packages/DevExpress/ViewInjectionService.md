https://www.devexpress.com/Support/Center/Example/Details/T220725/how-to-use-viewinjectionservice

common 所指定 Region 就是要從 ViewInjectionManager 取出的 instance

這個機制下的 ViewModel 不需要繼承/實作

```xml
<Grid>
    <Grid.RowDefinitions>
        <RowDefinition Height="Auto"/>
        <RowDefinition Height="*"/>
    </Grid.RowDefinitions>
    <dxui:TileBar Padding="10">
        <dxmvvm:Interaction.Behaviors>
            <dxmvvm:ViewInjectionService RegionName="{x:Static common:Regions.Navigation}" />
        </dxmvvm:Interaction.Behaviors>
    </dxui:TileBar>
    <dx:LoadingDecorator Grid.Row="1" >
        <dxwui:FlipView>
            <dxmvvm:Interaction.Behaviors>
                <dxmvvm:ViewInjectionService RegionName="{x:Static common:Regions.Main}"/>
            </dxmvvm:Interaction.Behaviors>
        </dxwui:FlipView>
    </dx:LoadingDecorator>
</Grid>
```

```csharp
public enum ModuleType {
    Customers,
    Sales,
    Products
}

public static class Regions {
    public static string Main { get { return "MainRegion"; } }
    public static string Navigation { get { return "NavigationRegion"; } }
}
```

App.xaml.cs

```csharp
public partial class App : Application {
    private void Application_Startup(object sender, StartupEventArgs e) {
        InitModules();
        DevExpress.Xpf.Core.ApplicationThemeHelper.UpdateApplicationThemeName();
    }
    private void InitModules() {
        ViewInjectionManager.Default.Inject(
            Regions.Navigation,
            ModuleType.Customers,
            () => NavigationItemViewModel.Create("Customers", new BitmapImage(new Uri(@"../Images/Customers.png", UriKind.RelativeOrAbsolute)), ModuleType.Customers),
            typeof(NavigationItemView)
        );
        ViewInjectionManager.Default.Inject(
            Regions.Navigation,
            ModuleType.Sales,
            () => NavigationItemViewModel.Create("Sales", new BitmapImage(new Uri(@"../Images/Sales.png", UriKind.RelativeOrAbsolute)), ModuleType.Sales),
            typeof(NavigationItemView)
        );
        ViewInjectionManager.Default.Inject(
            Regions.Navigation,
            ModuleType.Products,
            () => NavigationItemViewModel.Create("Products", new BitmapImage(new Uri(@"../Images/Products.png", UriKind.RelativeOrAbsolute)), ModuleType.Products),
            typeof(NavigationItemView)
        );
        ViewInjectionManager.Default.Inject(Regions.Main, ModuleType.Customers, () => CustomersViewModel.Create(), typeof(CustomersView));
        ViewInjectionManager.Default.Inject(Regions.Main, ModuleType.Sales, () => SalesViewModel.Create(), typeof(SalesView));
        ViewInjectionManager.Default.Inject(Regions.Main, ModuleType.Products, () => ProductsViewModel.Create(), typeof(ProductsView));

        ViewInjectionManager.Default.Navigate(Regions.Navigation, ModuleType.Customers);
        ViewInjectionManager.Default.Navigate(Regions.Main, ModuleType.Customers);

    }
}
```
