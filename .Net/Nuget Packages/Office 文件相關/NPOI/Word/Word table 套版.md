# Word table 套版

### 範例 01

-   只有一個 Table
-   該 Table 有二個 Row
    -   第一個 Row：group by => RelativePath
    -   第二個 Row：為第一個 Row 的 group rows => FileName / Comment

```cs
public async Task<string> ExportWord(SettingDto settingDto, FileCommentDto?[] fileCommentDtos)
{
    var exportFilePath = CheckOutputFileStatus($"{settingDto.Name}.docx");

    // 以 NOPI 套件開啟範本檔案
    using var stream = File.OpenRead(_wordTemplatePath);
    using var doc    = new XWPFDocument(stream);

    var table           = doc.Tables[0];
    // 複製 TemplateRows
    var templatePathRow = table.GetRow(0).Copy();
    var templateFileRow = table.GetRow(1).Copy();
    // 刪除 TemplateRows
    table.RemoveRow(1);
    table.RemoveRow(0);

    foreach (var group in fileCommentDtos.GroupBy(x => x?.RelativePath))
    {
        var pathRow = templatePathRow.Copy();
        pathRow.GetCell(0).Paragraphs[0].ReplaceText("{{RelativePath}}", group.Key ?? string.Empty);
        table.AddRow(pathRow);

        foreach (var fileCommentDto in group)
        {
            var fileRow = templateFileRow.Copy();
            fileRow.GetCell(0).Paragraphs[0].ReplaceText("{{FileName}}", fileCommentDto?.FileName ?? string.Empty);
            fileRow.GetCell(1).Paragraphs[0].ReplaceText("{{Comment}}", fileCommentDto?.Comment   ?? string.Empty);

            table.AddRow(fileRow);
        }
    }

    // 在寫入檔案後，要關閉檔案，後續才可以被其他應用程式開啟
    using var openFileStream = File.Create(exportFilePath);
    doc.Write(openFileStream);

    return exportFilePath;
}

private static string CheckOutputFileStatus(string fileName)
{
    var exportFolderPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "output");
    if (Directory.Exists(exportFolderPath) == false)
    {
        Directory.CreateDirectory(exportFolderPath);
    }

    var exportFilePath = Path.Combine(exportFolderPath, fileName);
    if (File.Exists(exportFilePath))
    {
        File.Delete(exportFilePath);
    }
    return exportFilePath;
}
```

### 範例 02

複製第一個 Table 然後再空一個，貼上三次

```cs
var templatePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Template.docx");

using var stream = File.OpenRead(templatePath);
using var doc    = new XWPFDocument(stream);


var table = doc.Tables[0];

// delete table
// doc.RemoveBodyElement(doc.GetPosOfTable(table));

var clonedTable = table.Copy();

for (int i = 0; i < 3; i++)
{
    doc.CreateTable();
    doc.SetTable(doc.Tables.Count - 1, clonedTable);

    // doc.CreateParagraph().CreateRun().AddBreak();
    doc.CreateParagraph().CreateRun().AddBreak(BreakType.PAGE);
}

using var outputStream = File.Create(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Output.docx"));

doc.Write(outputStream);
```
