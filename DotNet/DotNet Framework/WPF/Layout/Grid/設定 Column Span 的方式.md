# 設定 Column Span 的方式

目前還找不到 ColumnSpan 可以欄位置中的方式

```xml
<Grid>
    <!-- Column / Row Definitions -->
    <Grid.ColumnDefinitions>
        <ColumnDefinition></ColumnDefinition>
        <ColumnDefinition></ColumnDefinition>
    </Grid.ColumnDefinitions>
    <Grid.RowDefinitions>
        <RowDefinition></RowDefinition>
        <RowDefinition></RowDefinition>
    </Grid.RowDefinitions>

    <StackPanel Grid.Row="0" HorizontalAlignment="Center">
        <Label Content="TextBoxValueA" />
        <Label Content="{Binding TextBoxValueA}" />
        <Label Content="TextBoxValueB" />
        <Label Content="{Binding TextBoxValueB}" />
    </StackPanel>

    <iChildView:IChildAView Grid.Column="0" Grid.Row="1" />
    <iChildView:IChildBView Grid.Column="1" Grid.Row="1"/>

    <!-- 指定 ColumnSpan - 要放在 Content 之後 -->
    <!-- 在這裡指定 ColumnSpan -->
    <GridSplitter Grid.Row="0" Grid.Column="0" Grid.ColumnSpan="2" Width="Auto"  />
    <GridSplitter Grid.Row="1" Grid.Column="0"                     />

</Grid>
```
