# [FocusBehavior](https://documentation.devexpress.com/WPF/17370/MVVM-Framework/Behaviors/Predefined-Set/FocusBehavior)

1. 該元件啟動時，會自動 Focus 至該 Element

   ```xml
   <TextBox Text="This control is focused on startup">
       <dxmvvm:Interaction.Behaviors>
           <dxmvvm:FocusBehavior/>
       </dxmvvm:Interaction.Behaviors>
   </TextBox>
   ```

1. 指定其他 Element Event 來 Focus 至此 Element

    - SourceName
    - EventName

   ```xml
   <TextBox Text="This control is focused on button click: ">
       <dxmvvm:Interaction.Behaviors>
           <dxmvvm:FocusBehavior SourceName="button" EventName="Click"/>
       </dxmvvm:Interaction.Behaviors>
   </TextBox>
   <Button x:Name="button" Content="Click to focus the TextBox"/>
   ```

1. 指定某個 Property Changed 才 Focus

    - SourceObject
    - PropertyName

   ```xml
   <TextBox Text="This control is focused when data is loaded">
       <dxmvvm:Interaction.Behaviors>
           <dxmvvm:FocusBehavior SourceObject="{Binding ViewModel}" PropertyName="IsDataLoaded"/>
       </dxmvvm:Interaction.Behaviors>
   </TextBox>
   ```

1. 觸發 Event 後 Delay 指定時間 才 Focus

    - FocusDelay

    ```xml
    <TextBox Text="This control is focused on button click: ">
        <dxmvvm:Interaction.Behaviors>
            <dxmvvm:FocusBehavior SourceName="button" EventName="Click" FocusDelay="0:00:03"/>
        </dxmvvm:Interaction.Behaviors>
    </TextBox>
    <Button x:Name="button" Content="Click to focus the TextBox"/>
    ```
