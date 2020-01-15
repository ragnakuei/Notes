# Binding Converter

在 View 上做立即的轉換，而不需要額外處理 Model

```xml
<!-- 定義 Converter 的 Key Type Mapping -->
<Window.Resources>
    <local:DateConverter x:Key="dateConverter"/>
</Window.Resources>
<Window.DataContext>
    <local:MainViewModel/>
</Window.DataContext>
<StackPanel>
    <TextBlock Grid.Row="2" Grid.Column="0" Margin="0,0,8,0" Name="startDateTitle">Start Date:</TextBlock>

    <TextBlock Name="StartDateDTKey" Grid.Row="2" Grid.Column="1" Text="{Binding StartDate, Converter={StaticResource dateConverter}}" />
</StackPanel>
```

Converter 實作

```csharp
[ValueConversion(typeof(DateTime), typeof(String))]
public class DateConverter : IValueConverter
{
    public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
    {
        if(value is DateTime date)
        {
            return date.ToShortDateString();
        }

        return string.Empty;
    }

    public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
    {
        string strValue = value as string;
        DateTime resultDateTime;
        if (DateTime.TryParse(strValue, out resultDateTime))
        {
            return resultDateTime;
        }
        return DependencyProperty.UnsetValue;
    }
}
```
