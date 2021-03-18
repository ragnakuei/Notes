# ItemsControl

- [ItemsControl](#itemscontrol)
  - [Sample](#sample)
    - [搭配 Grid](#%e6%90%ad%e9%85%8d-grid)
    - [於 xaml 中指定 Items](#%e6%96%bc-xaml-%e4%b8%ad%e6%8c%87%e5%ae%9a-items)
  - [ItemsPanelTemplate](#itemspaneltemplate)
  - [ItemTemplate](#itemtemplate)

---

## Sample

### 搭配 Grid

```xml
<Grid>
    <ItemsControl ItemsSource="{Binding OrderList}">
        <ItemsControl.ItemTemplate>
            <DataTemplate>
                <TextBlock Text="{Binding OrderId}"></TextBlock>
            </DataTemplate>
        </ItemsControl.ItemTemplate>
    </ItemsControl>
</Grid>
```

### 於 xaml 中指定 Items

```xml
<Grid Margin="10">
    <ItemsControl>
        <ItemsControl.ItemsPanel>
            <ItemsPanelTemplate>
                <StackPanel />
            </ItemsPanelTemplate>
        </ItemsControl.ItemsPanel>
        <ItemsControl.ItemTemplate>
            <DataTemplate>
                <Button Content="{Binding}" Margin="0,0,5,5" />
            </DataTemplate>
        </ItemsControl.ItemTemplate>

        <!-- 指定 Items -->
        <system:String>Item #1</system:String>
        <system:String>Item #2</system:String>
        <system:String>Item #3</system:String>
        <system:String>Item #4</system:String>
        <system:String>Item #5</system:String>
    </ItemsControl>
</Grid>
```

---

## ItemsPanelTemplate

用來指定 Items 存放的 Layout，例：Grid、StackPanel…等。Layout 內不可以有任何內容

---

## ItemTemplate

指定 Items 中，各 Item 的樣版

將陣列內各筆資料，Binding 至 ItemTemplate 中，最後再把所有 ItemTemplate 的結果，放進 ItemsPanelTemplate 所指定的容器中

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

---


