# [TrackBarEdit](https://docs.devexpress.com/WPF/116531/controls-and-libraries/data-editors/common-features/editor-operation-modes/trackbaredit)

要 Binding 的 Property 是 `EditValue` ，不是 `Value`

## 參考

-   [How to: Create and Customize a RangeTrackBarEdit](https://docs.devexpress.com/WPF/10508/controls-and-libraries/data-editors/getting-started/how-to-create-and-customize-a-rangetrackbaredit)

## 範例

```xml
<dxe:TrackBarEdit Minimum="1"
                    Maximum="10"
                    TickItemDisplayMode="TickAndText"
                    TickPlacement="BottomRight"
                    ValueToolTipPlacement="TopLeft"
                    TickFrequency="1"
                    EditValue="{Binding SelectedThickness, UpdateSourceTrigger=PropertyChanged}">
    <dxe:TrackBarEdit.StyleSettings>
        <dxe:TrackBarStyleSettings />
    </dxe:TrackBarEdit.StyleSettings>
</dxe:TrackBarEdit>
```
