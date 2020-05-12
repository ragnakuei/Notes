# Label

## 讓產生 Label 時，就可以取出長寬

```csharp
var label = new Label
{
    Content = title
};
label.Measure(new Size(double.PositiveInfinity, double.PositiveInfinity));
var labelSize = label.DesiredSize;
```
