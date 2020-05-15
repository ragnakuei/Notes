# Grid

可以分成幾個部份來看

| 區域              | 功能         |
| ----------------- | ------------ |
| ColumnDefinitions | 欄定義       |
| RowDefinitions    | 列定義       |
| Content           | 各 Cell 定義 |

> 註：2* 1* 1* 的意思是指整個的比例。就是整個加起來為四個等份，第一個佔了二等份，第二個佔了一等份，第三個佔了一等份。

```xml
<Grid>
    <Grid.ColumnDefinitions>
        <ColumnDefinition Width="2*" />
        <ColumnDefinition Width="1*" />
        <ColumnDefinition Width="1*" />
    </Grid.ColumnDefinitions>
    <Grid.RowDefinitions>
        <RowDefinition Height="2*" />
        <RowDefinition Height="1*" />
    </Grid.RowDefinitions>

    <Label Grid.Column="0" Grid.Row="0">MainWindow</Label>
    <View:MainView Grid.Column="1" Grid.Row="1"/>
</Grid>
```
