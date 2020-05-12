# Trigger Animations

- [Trigger Animations](#trigger-animations)
  - [各 Property 所對應的 Animation Type](#%e5%90%84-property-%e6%89%80%e5%b0%8d%e6%87%89%e7%9a%84-animation-type)
  - [EnterActions](#enteractions)
  - [ExitActions](#exitactions)

---

## 各 Property 所對應的 Animation Type

| Property        | Animation          |
| --------------- | ------------------ |
| Height          | DoubleAnimation    |
| Width           | DoubleAnimation    |
| BorderThickness | ThicknessAnimation |
|                 |                    |

> 注意：如果用錯 Animation Type 就有可能會出現 Exception

---

## EnterActions

符合指定 Event 時，所指定的動作

## ExitActions

在符合指定 Event 時，再次滿足不符合指定 Event，所指定的動作

```xml
<Grid>
    <Border Background="LightGreen" Width="100" Height="100" BorderBrush="Green">
        <Border.Style>
            <Style TargetType="Border">
                <Style.Triggers>
                    <Trigger Property="IsMouseOver" Value="True">
                        <Trigger.EnterActions>
                            <BeginStoryboard>
                                <Storyboard>
                                    <ThicknessAnimation Duration="0:0:0.400" To="3" Storyboard.TargetProperty="BorderThickness" />
                                    <DoubleAnimation Duration="0:0:0.300" To="125" Storyboard.TargetProperty="Height" />
                                    <DoubleAnimation Duration="0:0:0.300" To="125" Storyboard.TargetProperty="Width" />
                                </Storyboard>
                            </BeginStoryboard>
                        </Trigger.EnterActions>
                        <Trigger.ExitActions>
                            <BeginStoryboard>
                                <Storyboard>
                                    <ThicknessAnimation Duration="0:0:0.250" To="0" Storyboard.TargetProperty="BorderThickness" />
                                    <DoubleAnimation Duration="0:0:0.150" To="100" Storyboard.TargetProperty="Height" />
                                    <DoubleAnimation Duration="0:0:0.150" To="100" Storyboard.TargetProperty="Width" />
                                </Storyboard>
                            </BeginStoryboard>
                        </Trigger.ExitActions>
                    </Trigger>
                </Style.Triggers>
            </Style>
        </Border.Style>
    </Border>
</Grid>
```
