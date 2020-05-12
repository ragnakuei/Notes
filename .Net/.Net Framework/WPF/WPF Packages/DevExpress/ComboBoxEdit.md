# ComboBoxEdit

- [ComboBoxEdit](#comboboxedit)
  - [Binding 做法](#binding-%e5%81%9a%e6%b3%95)

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
