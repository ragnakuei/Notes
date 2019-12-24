# [UpdateSourceTrigger](https://docs.microsoft.com/en-us/dotnet/api/system.windows.data.binding.updatesourcetrigger)

| enum            | 說明                                                                                                                                             |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Default         | 預設值。 大多數相依性屬性的預設值為 UpdateSourceTrigger.PropertyChanged，而 TextBox.Text 屬性具以 UpdateSourceTrigger.LostFocus" /> 做為預設值。 |
| PropertyChanged | 每當繫結目標屬性變更時，就會立即更新繫結來源。                                                                                                   |
| LostFocus       | 每當繫結目標項目失焦時，就會更新繫結來源。                                                                                                       |
| Explicit        | 只有在呼叫 BindingExpression.UpdateSource 方法時，才會更新繫結來源。                                                                             |

## Explicit - 手動更新 Sample

```xml
<TextBox Name="itemNameTextBox"
         Text="{Binding Path=ItemName, UpdateSourceTrigger=Explicit}" />
```

```csharp
var be = itemNameTextBox.GetBindingExpression(TextBox.TextProperty);
be.UpdateSource();
```
