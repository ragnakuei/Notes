# [Dock Layout Manager](https://documentation.devexpress.com/wpf/6820/Controls-and-Libraries/Layout-Management/Dock-Windows/Getting-Started/Dock-Layout-Manager)

二種 Layout 元件
 - LayoutGroup
 - TabbedGroup

Layout 元件內，可直接擺放 LayoutPanel

## 在 DocumentGroup 內放 LayoutPanel 來達到 Tab 效果

Tab List 會在上方

```xml
<dxdo:DocumentGroup x:Name="layoutGroup1" >
    <dxdo:LayoutPanel Caption="Panel1">
        <Label>Panel1</Label>
    </dxdo:LayoutPanel>
    <dxdo:LayoutPanel Caption="Panel2">
        <Label>Panel2</Label>
    </dxdo:LayoutPanel>
</dxdo:DocumentGroup>
```

## TabbedGroup + LayoutPanel

Tab List 會在下方

```xml
<dxdo:DockLayoutManager Margin="12" Name="dockManager1" dxcore:ThemeManager.ThemeName="Office2007Blue">
    <dxdo:LayoutGroup x:Name="rootGroup" Orientation="Horizontal" >
        <dxdo:TabbedGroup x:Name="layoutGroup1" ShowControlBox="True">
            <!-- Tab 內的所有 LayoutPanel 項目 -->
            <dxdo:LayoutPanel Caption="Panel1">
                <Label>Panel1</Label>
            </dxdo:LayoutPanel>
            <dxdo:LayoutPanel Caption="Panel2">
                <Label>Panel2</Label>
            </dxdo:LayoutPanel>
            
        </dxdo:TabbedGroup>
        
        <dxdo:DocumentGroup>
            <dxdo:DocumentPanel  Caption="Document 1">
                <RichTextBox/>
            </dxdo:DocumentPanel>
        </dxdo:DocumentGroup>
    </dxdo:LayoutGroup>
</dxdo:DockLayoutManager>
```

## 參考資料

- [產生 DocumentPanel 的方式](dockingdocumentuiservice.md)

