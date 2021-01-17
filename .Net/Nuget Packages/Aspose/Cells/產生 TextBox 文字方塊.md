# 產生 TextBox 文字方塊

```csharp
var applicaionNoTextBoxIndex = sheet.TextBoxes.Add(5, 0, 20, 100);
var applicaionNoTextBox      = sheet.TextBoxes[applicaionNoTextBoxIndex];
applicaionNoTextBox.Text      = dto.ApplicationNo;
applicaionNoTextBox.Font.Size = 11;

// 去除線條外框
applicaionNoTextBox.LineFormat.IsVisible = false;

// 無填滿
applicaionNoTextBox.Fill.Type = FillType.None;
```

