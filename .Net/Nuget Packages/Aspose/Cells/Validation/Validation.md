# Validation

- v19.11 前的寫法

  透過 `validations.Add()` 來新增 Validation 後，再來新增 CellArea

- v19.11 後的寫法

  > [v19.11 ReleaseNotes](<https://docs.aspose.com/display/cellsnet/Aspose.Cells+for+.NET+19.11+Release+Notes#Aspose.Cellsfor.NET19.11ReleaseNotes-Addsmethods:Validation.AddArea(CellArea,bool,bool),AddAreas(CellArea[],bool,bool),RemoveAreas(CellArea[])>)

  > 增加了 `Validation.AddArea(CellArea)`

  要先加入 CellArea 後，再從 Validations 裡面取出 Validation

  完整語法可參考 [整數](./整數.md)

  ```csharp
  var validations = workbook.Worksheets[0].Validations;

  CellArea area = new CellArea
  {
      StartRow = 0,
      EndRow = 1,
      StartColumn = 0,
      EndColumn = 1,
  };

  Validation validation = validations[validations.Add(area)];
  ```
