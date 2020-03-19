# xaml

- [xaml](#xaml)
  - [語法](#%e8%aa%9e%e6%b3%95)
    - [Sample ： 結構語法](#sample--%e7%b5%90%e6%a7%8b%e8%aa%9e%e6%b3%95)
    - [Sample ： 以 xaml 來描述物件](#sample--%e4%bb%a5-xaml-%e4%be%86%e6%8f%8f%e8%bf%b0%e7%89%a9%e4%bb%b6)
    - [Sample：以 enum 來給定 Property 的值](#sample%e4%bb%a5-enum-%e4%be%86%e7%b5%a6%e5%ae%9a-property-%e7%9a%84%e5%80%bc)

---

## 語法

### Sample ： 結構語法

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

### Sample ： 以 xaml 來描述物件

```csharp
public class User
{
    public int Id { get; set; }
    public string Name { get; set; }
}
```

```xml
<StackPanel>
    <Grid Margin="10">
        <ItemsControl>
            <ItemsControl.ItemsPanel>
                <ItemsPanelTemplate>
                    <StackPanel />
                </ItemsPanelTemplate>
            </ItemsControl.ItemsPanel>
            <ItemsControl.ItemTemplate>
                <DataTemplate>
                    <GroupBox>
                        <StackPanel>
                            <TextBlock Text="{Binding Id}"/>
                            <TextBlock Text="{Binding Name}"/>
                        </StackPanel>
                    </GroupBox>
                </DataTemplate>
            </ItemsControl.ItemTemplate>
            <local:User>
                <local:User.Id>1</local:User.Id>
                <local:User.Name>A</local:User.Name>
            </local:User>
            <local:User>
                <local:User.Id>2</local:User.Id>
                <local:User.Name>B</local:User.Name>
            </local:User>
            <local:User>
                <local:User.Id>3</local:User.Id>
                <local:User.Name>C</local:User.Name>
            </local:User>
        </ItemsControl>
    </Grid>
</StackPanel>
```

### Sample：以 enum 來給定 Property 的值

要給定 AccordionItem.Tag 

```xml
<dxa:AccordionItem Header="PCB">
    <dxa:AccordionItem.Tag>
        <x:Static Member="parameter:DropMenuItemType.A" />
    </dxa:AccordionItem.Tag>
</dxa:AccordionItem>
```

```csharp
public enum DropMenuItemType
{
    A,
    B,
    C,
}
```
