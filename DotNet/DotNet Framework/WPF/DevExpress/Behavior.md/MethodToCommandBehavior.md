# [MethodToCommandBehavior](https://documentation.devexpress.com/WPF/113800/MVVM-Framework/Behaviors/Predefined-Set/MethodToCommandBehavior)

- [MethodToCommandBehavior](#methodtocommandbehavior)
  - [TextBox Sample](#textbox-sample)
  - [BarManager Sample](#barmanager-sample)

---

用來定義觸發 Command 時，要執指指定控制項內的某個 Method

Method 引數，可以是 View 中某個控制項的某個 Property

---

## TextBox Sample

建立二個 Button 及一個 TextBox

- 第一個 Button 按下去會選取 TextBox Index 2 (含) 之後的四個字元
- 第二個 Button 按下去會把焦點移至 TextBox 中

```xml
<TextBox Name="tbx" Text="01234567890" />
<Button Content="Select Text">
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:MethodToCommandBehavior Source="{Binding ElementName=tbx}"
                                        Method="Select"
                                        Arg1="2"
                                        Arg2="4"
                                        >
        </dxmvvm:MethodToCommandBehavior>
    </dxmvvm:Interaction.Behaviors>
</Button>
<Button Content="Focus Textbox">
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:MethodToCommandBehavior Source="{Binding ElementName=tbx}"
                                        Method="Focus"
        >
        </dxmvvm:MethodToCommandBehavior>
    </dxmvvm:Interaction.Behaviors>
</Button>
```

---

## BarManager Sample

- Source 要呼叫的 Target
- Method 要呼叫的 Target Method
- ArgX 要呼叫的 Target Method 的引數

  可以看一下 Arg1 及 Arg2 的參數給定方式

  - Arg1 就是要取出另一個控制項的值
  - Arg2 就是要取出指定常數的值

```xml
<dxb:BarManager>
    <dxb:BarManager.Bars>
        <dxb:Bar Caption="Column Sorting Bar">
            <dxb:BarButtonItem Content="Descending" Glyph="{dx:DXImage Image=MoveDown_16x16.png}" BarItemDisplayMode="ContentAndGlyph">
                <dxmvvm:Interaction.Behaviors>
                    <dxmvvm:MethodToCommandBehavior Source="{Binding ElementName=gridControl}"
                                                    Method="SortBy"
                                                    Arg1="{Binding ElementName=gridControl,Path=CurrentColumn}">
                        <dxmvvm:MethodToCommandBehavior.Arg2>
                            <dxdata:ColumnSortOrder>
                                Descending
                            </dxdata:ColumnSortOrder>
                        </dxmvvm:MethodToCommandBehavior.Arg2>
                    </dxmvvm:MethodToCommandBehavior>
                </dxmvvm:Interaction.Behaviors>
            </dxb:BarButtonItem>
            <dxb:BarButtonItem Content="Ascending" Glyph="{dx:DXImage Image=MoveUp_16x16.png}" BarItemDisplayMode="ContentAndGlyph">
                <dxmvvm:Interaction.Behaviors>
                    <dxmvvm:MethodToCommandBehavior Source="{Binding ElementName=gridControl}"
                                                    Method="SortBy"
                                                    Arg1="{Binding ElementName=gridControl,Path=CurrentColumn}">
                        <dxmvvm:MethodToCommandBehavior.Arg2>
                            <dxdata:ColumnSortOrder>
                                Ascending
                            </dxdata:ColumnSortOrder>
                        </dxmvvm:MethodToCommandBehavior.Arg2>
                    </dxmvvm:MethodToCommandBehavior>
                </dxmvvm:Interaction.Behaviors>
            </dxb:BarButtonItem>
            <dxb:BarButtonItem Content="Clear Sorting" Glyph="{dx:DXImage Image=Clear_16x16.png}" BarItemDisplayMode="ContentAndGlyph">
                <dxmvvm:Interaction.Behaviors>
                    <dxmvvm:MethodToCommandBehavior Source="{Binding ElementName=gridControl}"
                        Method="ClearGrouping" />
                </dxmvvm:Interaction.Behaviors>
            </dxb:BarButtonItem>
        </dxb:Bar>
    </dxb:BarManager.Bars>
    <Grid>
        <dxg:GridControl x:Name="gridControl" ItemsSource="{Binding Users}" AutoGenerateColumns="AddNew">
            <dxg:GridControl.View>
                <dxg:TableView x:Name="tableView" ShowGroupPanel="False" FadeSelectionOnLostFocus="False" />
            </dxg:GridControl.View>
        </dxg:GridControl>
    </Grid>
</dxb:BarManager>
```
