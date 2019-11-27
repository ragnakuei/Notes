# [BoundField](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.webcontrols.boundfield)

單純顯示資料，無法做複雜的邏輯

- 設定資料格式的方式

  透過 DataFormatString

  ```html
  <asp:BoundField
    DataField="ShippedDate"
    HeaderText="ShippedDate"
    InsertVisible="False"
    ReadOnly="True"
    DataFormatString="{0:yyyy/MM/dd}"
  />
  ```
