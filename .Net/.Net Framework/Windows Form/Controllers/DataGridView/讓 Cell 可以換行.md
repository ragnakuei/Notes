# 讓 Cell 可以換行

```cs
// 讓 Cell 可以用 shift + enter 換行
dgv.DefaultCellStyle.WrapMode = DataGridViewTriState.True;

// 讓 Cell 可以自動調整 Row Height
dgv.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells;
```