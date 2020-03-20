# xaml 內套用 nameof

```csharp
public class NameOfExtension : MarkupExtension
{
    private readonly PropertyPath _propertyPath;

    public NameOfExtension(Binding binding)
    {
        _propertyPath = binding.Path;
    }

    public override object ProvideValue(IServiceProvider serviceProvider)
    {
        var indexOfLastVariableName = _propertyPath.Path.LastIndexOf('.');
        return _propertyPath.Path.Substring(indexOfLastVariableName + 1);
    }
}
```

Binding MaterialsModel 的 Property => Name

```xml
<dxg:GridColumn Header="Name" FieldName="{ helpers:NameOf {Binding MaterialsModel.Name}}" />
```
