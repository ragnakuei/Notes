# 將 View 內的某控制項的值綁定到另一個控制項中

```xml
<TextBox Name="TextBox1"></TextBox>
<subUserControl:ESubUserControl1 
                UserName="{Binding Path=Text, ElementName=TextBox1, Mode=OneWay}" />
```