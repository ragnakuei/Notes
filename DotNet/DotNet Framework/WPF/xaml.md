# xaml

---

## 語法

以下三種語法的功能完全一樣

```xml
<TextBox Text="{Binding TextBoxValue, UpdateSourceTrigger=PropertyChanged}" />
```

```xml
<TextBox>
    <TextBox.Text>
        <Binding Path="TextBoxValue" UpdateSourceTrigger="PropertyChanged" />
    </TextBox.Text>
</TextBox>
```

```xml
<TextBox>
    <TextBox.Text>
        <Binding Path="TextBoxValue">
            <Binding.UpdateSourceTrigger>PropertyChanged</Binding.UpdateSourceTrigger>
        </Binding>
    </TextBox.Text>
</TextBox>
```
