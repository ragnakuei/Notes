# [DatePicker](https://github.com/MaterialDesignInXAML/MaterialDesignInXamlToolkit/blob/master/MainDemo.Wpf/Pickers.xaml)

- [DatePicker](#datepicker)
  - [設定](#%e8%a8%ad%e5%ae%9a)
  - [基本範例](#%e5%9f%ba%e6%9c%ac%e7%af%84%e4%be%8b)

---

## 設定

| attribute                      | 說明                                                                        |
| ------------------------------ | --------------------------------------------------------------------------- |
| Style                          | 一律指向 `StaticResource MaterialDesignFloatingHintDatePicker` 來套用 Style |
| materialDesign:HintAssist.Hint | 設定 placeholder 文字                                                       |
|                                |                                                                             |

---

## 基本範例

```xml
<DatePicker
  Width="100"
  materialDesign:HintAssist.Hint="Pick Date"
  Style="{StaticResource MaterialDesignFloatingHintDatePicker}"
/>
```
