# AccordionControl

- [AccordionControl](#accordioncontrol)
  - [xaml 範例](#xaml-%e7%af%84%e4%be%8b)
  - [csharp 範例](#csharp-%e7%af%84%e4%be%8b)
    - [Vertical ScrollBar](#vertical-scrollbar)

## xaml 範例

```xml
<dxa:AccordionControl
    MaxWidth="200"
    ChildrenPath="Employees"
    DockPanel.Dock="Left"
    IsCollapseButtonVisible="True">
    <dxa:AccordionItem
        Glyph="{dx:DXImage Image=Image_32x32.png}"
        Header="Root Item 1"
        ShowInCollapsedMode="True">
        <dxa:AccordionItem Glyph="{dx:DXImage Image=Image_16x16.png}" Header="SubItem 1-1" />
        <dxa:AccordionItem Glyph="{dx:DXImage Image=Image_16x16.png}" Header="SubItem 1-2" />
    </dxa:AccordionItem>
    <dxa:AccordionItem
        Name="accordionItemRootItem2"
        Glyph="{dx:DXImage Image=Map_32x32.png}"
        Header="Root Item 2">
        <dxa:AccordionItem
            Glyph="{dx:DXImage Image=Map_16x16.png}"
            Header="SubItem 2-1"
            ShowInCollapsedMode="True" />
    </dxa:AccordionItem>
</dxa:AccordionControl>
```

## csharp 範例

```csharp
var item = new AccordionItem
{
    Name = "Test",
    Header = "SubItem 2-2",
};

accordionItemRootItem2.Items.Add(item);
```

### Vertical ScrollBar

需要設定三個 Property
- ScrollBarMode="Standard"
- VerticalScrollBarVisibility="Auto"
- MaxHeight="200"

> 當 AccordionControl 的 Height 超過 MaxHeight 時，才會讓 Vertical Scrollbar 有作用

```xml
<dxa:AccordionControl
        AutoExpandAllItems="True"
        IsCollapseButtonVisible="True"
        ScrollBarMode="Standard"
        VerticalScrollBarVisibility="Auto"
        MaxHeight="200"
>
    <dxa:AccordionItem
        Glyph="{dx:DXImage Image=Image_32x32.png}"
        Header="Root Item 1"
        ShowInCollapsedMode="True">
        <dxa:AccordionItem Glyph="{dx:DXImage Image=Image_16x16.png}" Header="SubItem 1-1" />
        <dxa:AccordionItem Glyph="{dx:DXImage Image=Image_16x16.png}" Header="SubItem 1-2" />
    </dxa:AccordionItem>
    <dxa:AccordionItem
        Name="accordionItemRootItem2"
        Glyph="{dx:DXImage Image=Map_32x32.png}"
        Header="Root Item 2">
        <dxa:AccordionItem
            Glyph="{dx:DXImage Image=Map_16x16.png}"
            Header="SubItem 2-1"
            ShowInCollapsedMode="True" />
    </dxa:AccordionItem>
</dxa:AccordionControl>
```