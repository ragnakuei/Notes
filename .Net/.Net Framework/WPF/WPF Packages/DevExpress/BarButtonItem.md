# BarButtonItem

## 讓 Hint 可以換行的方式

1. 要將 RibbonStyle 設定成 RibbonItemStyles.Large
1. 要手動透過 Environment.NewLine 來處理換行，無法透過 xaml 來處理

```c#
var barButtonItem = new BarButtonItem();
barButtonItem.RibbonStyle = RibbonItemStyles.Large;
barButtonItem.Hint = "A" + Environment.NewLine + "B";
```

[參考資料](https://documentation.devexpress.com/WPF/DevExpress.Xpf.Bars.BarItem.SuperTip.property)