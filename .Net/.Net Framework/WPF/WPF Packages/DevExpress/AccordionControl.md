# AccordionControl

- [AccordionControl](#accordioncontrol)
  - [xaml 範例](#xaml-%e7%af%84%e4%be%8b)
  - [csharp 範例](#csharp-%e7%af%84%e4%be%8b)

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