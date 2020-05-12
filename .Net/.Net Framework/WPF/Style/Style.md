# Style

---

## 可用的 Resource

Resources 裡面可以套用的東西很多，要找到對應的 Class 的`可能`方式：

> 找出該控制項的 Property Type

| Class Name      | 說明            |
| --------------- | --------------- |
| SolidColorBrush | 用來指定顏色    |
| Thickness       | 用來指定 margin |
|                 |                 |

---

## 指定至相同檔案 resource key

以下二個 Button 的 style 一樣，只差在宣告語法不同

```xml
<Window.Resources>
    <SolidColorBrush x:Key="foreground" Color="Blue" />
</Window.Resources>
<StackPanel HorizontalAlignment="Center"
            VerticalAlignment="Center">
    <Button Content="ABC" 
            Foreground="{StaticResource foreground}"
            Margin="10"
            />
    <Button Content="DEF" 
            Foreground="Blue"
            Margin="10"
            />
</StackPanel>
```
---

## 指定至 global resource key

以下二個 Button 的 style 一樣，只差在宣告語法不同

```xml
<Window.Resources>
    <SolidColorBrush x:Key="foreground" Color="Blue" />
</Window.Resources>
<StackPanel HorizontalAlignment="Center"
            VerticalAlignment="Center">
    <Button Content="ABC" 
            Foreground="{StaticResource foreground}"
            Margin="10"
            />
    <Button Content="DEF" 
            Foreground="Blue"
            Margin="10"
            />
</StackPanel>
```

---

## style 參考至相同檔案 resource key

- TargetType 必填
- 如果要此檔案全部套用，可不給定 style key
- global 設定方式與 上述相同

```xml
<Window.Resources>
    <SolidColorBrush x:Key="foreground" Color="Blue" />
    <Style TargetType="Button" x:Key="btn" >
        <Setter Property="Foreground" Value="Blue" />
    </Style>
</Window.Resources>
<StackPanel HorizontalAlignment="Center"
            VerticalAlignment="Center">
    <Button Content="ABC" 
            Foreground="{StaticResource foreground}"
            Margin="10"
            />
    <Button Content="DEF" 
            Margin="10"
            Style="{StaticResource btn}"
            />
</StackPanel>
```

---

## 單一條件式變更 Style

依照指定的條件來改變 Style

### Property Trigger

參考對象是自己的 Property，來改變自己的 Style

1. 給定預設的 Style
2. 指定條件 -指定的 Property 等於指定的值
3. 指定符合條件後要設定的 Style

```xml
<TextBlock Text="Hello, styled world!" FontSize="28" HorizontalAlignment="Center" VerticalAlignment="Center">
    <TextBlock.Style>
        <Style TargetType="TextBlock">
            <!-- 1 -->
            <Setter Property="Foreground" Value="Blue"></Setter>

            <Style.Triggers>
                <!-- 2 -->
                <Trigger Property="IsMouseOver" Value="True">

                    <!-- 3 -->
                    <Setter Property="Foreground" Value="Red" />
                    <Setter Property="TextDecorations" Value="Underline" />
                </Trigger>
            </Style.Triggers>
        </Style>
    </TextBlock.Style>
</TextBlock>
```

### Data Trigger 範例一

參考對象是別人的 Property，來改變自己的 Style

1. 給定預設的 Style
2. 指定參考對象的 Element 、 Property 及 值
3. 指定符合條件後要設定的 Style

```xml
<StackPanel>
    <CheckBox Name="cbSample" Content="Hello, world?" />
    <TextBlock HorizontalAlignment="Center" Margin="0,20,0,0" FontSize="48">
        <TextBlock.Style>
            <Style TargetType="TextBlock">
                <!-- 1 -->
                <Setter Property="Text" Value="No" />
                <Setter Property="Foreground" Value="Red" />
                <Style.Triggers>
                    <!-- 2 -->
                    <DataTrigger Binding="{Binding ElementName=cbSample, Path=IsChecked}" Value="True">
                        <!-- 3 -->
                        <Setter Property="Text" Value="Yes!" />
                        <Setter Property="Foreground" Value="Green" />
                    </DataTrigger>
                </Style.Triggers>
            </Style>
        </TextBlock.Style>
    </TextBlock>
</StackPanel>
```

### Data Trigger 範例二

下拉選單選到 A 時，顯示 A 對應的 Grid  
下拉選單選到 B 時，顯示 B 對應的 Grid

1. 給定預設的 Style
2. 指定參考對象的 Element 、 Property 及 值
3. 指定符合條件後要設定的 Style

```xml
<StackPanel>
    <ComboBox x:Name="comboMyCombo">
        <ComboBoxItem Tag="Show">A</ComboBoxItem>
        <ComboBoxItem Tag="Show">B</ComboBoxItem>
    </ComboBox>


    <Grid>
        <Grid.Style>
            <Style TargetType="Grid">
                <!-- 1 -->
                <Setter Property="Grid.Visibility" Value="Hidden" />
                <Style.Triggers>
                    <!-- 2 -->
                    <DataTrigger Binding="{Binding ElementName=comboMyCombo, Path=SelectedItem.Tag}" Value="A">
                        <!-- 3 -->
                        <Setter Property="Grid.Visibility" Value="Visible" />
                    </DataTrigger>
                </Style.Triggers>
            </Style>
        </Grid.Style>
    </Grid>
    <Grid>
        <Grid.Style>
            <Style TargetType="Grid">
                <Setter Property="Grid.Visibility" Value="Hidden" />
                <Style.Triggers>
                    <DataTrigger Binding="{Binding ElementName=comboMyCombo, Path=SelectedItem.Tag}" Value="B">
                        <Setter Property="Grid.Visibility" Value="Visible" />
                    </DataTrigger>
                </Style.Triggers>
            </Style>
        </Grid.Style>
    </Grid>

</StackPanel>
```


### Event Trigger

依照控制項本身的 Event 來改變 Style

1. 指定 Event
2. 指定在觸發事件後的動作
3. 以動畫的方式將指定的 Property 改成 To 所給定的值

```xml
<StackPanel>
    <TextBlock Name="lblStyled" Text="Hello, styled world!" FontSize="18" HorizontalAlignment="Center" VerticalAlignment="Center">
        <TextBlock.Style>
            <Style TargetType="TextBlock">
                <Style.Triggers>
                    <!-- 1 -->
                    <EventTrigger RoutedEvent="MouseEnter">
                        <!-- 2 -->
                        <EventTrigger.Actions>
                            <BeginStoryboard>
                                <Storyboard>
                                    <!-- 3 -->
                                    <DoubleAnimation Duration="0:0:0.300" Storyboard.TargetProperty="FontSize" To="28" />
                                </Storyboard>
                            </BeginStoryboard>
                        </EventTrigger.Actions>
                    </EventTrigger>

                    <!-- 1 -->
                    <EventTrigger RoutedEvent="MouseLeave">
                        <!-- 2 -->
                        <EventTrigger.Actions>
                            <BeginStoryboard>
                                <Storyboard>
                                    <!-- 3 -->
                                    <DoubleAnimation Duration="0:0:0.800" Storyboard.TargetProperty="FontSize" To="10" />
                                </Storyboard>
                            </BeginStoryboard>
                        </EventTrigger.Actions>
                    </EventTrigger>
                </Style.Triggers>
            </Style>
        </TextBlock.Style>
    </TextBlock>
</StackPanel>
```
---

## 多條件式變更 Style

同時滿足所有條件才會改變 Style

### MultiTrigger

參考對象是控制項本身的 Properties

```xml
<StackPanel>
    <TextBox VerticalAlignment="Center" HorizontalAlignment="Center" Text="Hover and focus here" Width="150">
        <TextBox.Style>
            <Style TargetType="TextBox">
                <Style.Triggers>
                    <MultiTrigger>
                        <MultiTrigger.Conditions>
                            <Condition Property="IsKeyboardFocused" Value="True" />
                            <Condition Property="IsMouseOver" Value="True" />
                        </MultiTrigger.Conditions>
                        <MultiTrigger.Setters>
                            <Setter Property="Background" Value="LightGreen" />
                        </MultiTrigger.Setters>
                    </MultiTrigger>
                </Style.Triggers>
            </Style>
        </TextBox.Style>
    </TextBox>
    <TextBox />
</StackPanel>
```

### MultiDataTrigger

參考對象是其他控制項的 Properties

```xml
<StackPanel>
    <CheckBox Name="cbSampleYes" Content="Yes" />
    <CheckBox Name="cbSampleSure" Content="I'm sure" />
    <TextBlock HorizontalAlignment="Center" Margin="0,20,0,0" FontSize="28">
        <TextBlock.Style>
            <Style TargetType="TextBlock">
                <Setter Property="Text" Value="Unverified" />
                <Setter Property="Foreground" Value="Red" />
                <Style.Triggers>
                    <MultiDataTrigger>
                        <MultiDataTrigger.Conditions>
                            <Condition Binding="{Binding ElementName=cbSampleYes, Path=IsChecked}" Value="True" />
                            <Condition Binding="{Binding ElementName=cbSampleSure, Path=IsChecked}" Value="True" />
                        </MultiDataTrigger.Conditions>
                        <Setter Property="Text" Value="Verified" />
                        <Setter Property="Foreground" Value="Green" />
                    </MultiDataTrigger>
                </Style.Triggers>
            </Style>
        </TextBlock.Style>
    </TextBlock>
    <TextBox />
</StackPanel>
```
