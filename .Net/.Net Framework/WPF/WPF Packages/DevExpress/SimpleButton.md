# SimpleButton

## 在 MVVM 下，設定一開始 Focus 的方式

```xml
<dx:SimpleButton Height="40"
                 Width="100"
                 Command="{Binding ClickOkCommand}"
                 Content="OK">
    <!-- 只要給定以下的 Behavior 就可以了 -->
    <dxmvvm:Interaction.Behaviors>
        <dxmvvm:FocusBehavior/>
    </dxmvvm:Interaction.Behaviors>
</dx:SimpleButton>
```

[參考資料](https://docs.devexpress.com/WPF/17370/mvvm-framework/behaviors/predefined-set/focusbehavior)
