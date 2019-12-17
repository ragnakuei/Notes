# Bindind

## Binding

```csharp
public partial class SvgWindow2 : Window
{
    public SvgWindow2()
    {
        InitializeComponent();

        DataContext = new ViewModel
        {
            Geometry = "M39.967 23.133c-0.211 0.189-0.523 0.199-0.748 0.028l-7.443-5.664l-3.526 21.095c-0.013 0.08-0.042 0.153-0.083 0.219  c-0.707 3.024-4.566 5.278-9.104 5.278c-5.087 0-9.226-2.817-9.226-6.28s4.138-6.281 9.226-6.281c2.089 0 4.075 0.466 5.689 1.324  l4.664-26.453c0.042-0.242 0.231-0.434 0.475-0.479c0.237-0.041 0.485 0.068 0.611 0.28l9.581 16.192  C40.227 22.637 40.178 22.945 39.967 23.133z"
        };
    }
}

public class ViewModel
{
    public string Geometry { get; set; }
}
```

```xml
<Path Fill="Black" Data="{Binding Geometry}" Stretch="Fill" />
```

## Binding Path

```csharp

```

```xml

```