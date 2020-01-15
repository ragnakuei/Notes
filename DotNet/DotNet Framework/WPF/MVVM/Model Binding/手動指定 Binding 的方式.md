# 手動指定 Binding 的方式

- [手動指定 Binding 的方式](#%e6%89%8b%e5%8b%95%e6%8c%87%e5%ae%9a-binding-%e7%9a%84%e6%96%b9%e5%bc%8f)
  - [範例一](#%e7%af%84%e4%be%8b%e4%b8%80)

---

## 範例一

將 TextBox 的值，Binding 至 TextBlock 中

```xml
<TextBox Name="txtValue" />
<WrapPanel Margin="0,10">
    <TextBlock Text="Value: " FontWeight="Bold" />
    <TextBlock Name="lblValue" />
</WrapPanel>
```

```csharp
lblValue.SetBinding(TextBlock.TextProperty
                    , new Binding("Text") { Source = txtValue });
```
