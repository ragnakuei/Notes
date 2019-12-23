# DataContext Binding

## Value Type Array

直接在 class 中給定 DataContext 為 string[] 的資料

```csharp
public partial class MainWindow{
    public MainWindow() {
        InitializeComponent();
        DataContext = new List<String>() { "Images/First.svg", "Images/Last.svg" };
    }
}
```

因為沒有 Class / Property 的關係，直接進行 Binding 就可以了

```xml
<Grid>
    <ListBox ItemsSource="{Binding}">
        <ListBox.ItemTemplate>
            <DataTemplate>
                <Label Content="{Binding}" />
            </DataTemplate>
        </ListBox.ItemTemplate>
    </ListBox>
</Grid>
```

---

## Object Type Array

直接在 class 中給定 DataContext 為 ImageItem[] 的資料

```csharp
public partial class MainWindow
{
    public MainWindow()
    {
        InitializeComponent();
        DataContext = new List<ImageItem>() {
            new ImageItem { ImageFile = "Images/First.svg"},
            new ImageItem { ImageFile = "Images/Last.svg"},
        };
    }
}

public class ImageItem
{
    public string ImageFile { get; set; }
}
```

當資料內容是 Object 時，就透過 `Binding Path` 所指定的 Property Name 來取值

```xml
<Grid>
    <ListBox ItemsSource="{Binding ImageFiles}">
        <ListBox.ItemTemplate>
            <DataTemplate>
                <Label Content="{Binding Path=ImageFile}" />

                <!-- 也可以這樣寫 -->
                <!-- <Label Content="{Binding ImageFile}" /> -->
            </DataTemplate>
        </ListBox.ItemTemplate>
    </ListBox>
</Grid>
```
