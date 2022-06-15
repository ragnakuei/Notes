# 取出指定 Row 的 Value


```cs
DataGridView.Rows[rowIndex].Cells[ColumnName].Value
```

該值可以直接 Assign 至 DataTable 的欄位中，而不需要再做轉換。

PS：

```
直接用 DataSource = DataTable ，然後從 DataTable 取出資料比較好

在設定了 DataGridView.AllowUserToAddRows = true 後
DataGridView.Rows 就必定會比 DataTable.Rows 多一個 Row
如果直接從 DataGridView.Rows 取出資料，就會需要額外判斷是否為 Empty Row !
```
