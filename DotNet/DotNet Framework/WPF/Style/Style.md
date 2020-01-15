# Style

- [Style](#style)
  - [單一條件式變更 Style](#%e5%96%ae%e4%b8%80%e6%a2%9d%e4%bb%b6%e5%bc%8f%e8%ae%8a%e6%9b%b4-style)
    - [Property Trigger](#property-trigger)
    - [Data Trigger](#data-trigger)
    - [Event Trigger](#event-trigger)
  - [多條件式變更 Style](#%e5%a4%9a%e6%a2%9d%e4%bb%b6%e5%bc%8f%e8%ae%8a%e6%9b%b4-style)
    - [MultiTrigger](#multitrigger)
    - [MultiDataTrigger](#multidatatrigger)

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

### Data Trigger

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
                        <!-- 1 -->
                        <Setter Property="Text" Value="Yes!" />
                        <Setter Property="Foreground" Value="Green" />
                    </DataTrigger>
                </Style.Triggers>
            </Style>
        </TextBlock.Style>
    </TextBlock>
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
