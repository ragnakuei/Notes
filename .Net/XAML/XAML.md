# [XAML](https://docs.microsoft.com/en-us/dotnet/framework/xaml-services/)


- [Generics in XAML](https://docs.microsoft.com/en-us/dotnet/framework/xaml-services/generics-in-xaml)

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