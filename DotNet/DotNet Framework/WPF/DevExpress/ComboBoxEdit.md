# ComboBoxEdit


## Binding 做法

```xml
<dxe:ComboBoxEdit
    DisplayMember="Name"
    ItemsSource="{Binding Tests}"
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
                Name = "A",
            },
            new Test
            {
                Id = 2,
                Name = "B",
            },
            new Test
            {
                Id = 3,
                Name = "C",
            },
        };
    }

    public ObservableCollection<Test> Tests { get; set; }
}

public class Test
{
    public int Id { get; set; }
    public string Name { get; set; }
}
```