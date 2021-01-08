# AlterColumn

在不改變欄位名稱的前提下進行的調整 !

## 範例

```csharp
migrationBuilder.AlterColumn<string>(
    name: "ActualFileName",
    schema: "dbo",
    table: "Attachment",
    type: "varchar(200)",
    maxLength: 200,
    nullable: false,
    comment: "檔案系統之檔案名稱",
    oldClrType: typeof(string),
    oldType: "varchar(200)",
    oldMaxLength: 200,
    oldNullable: true,
    oldComment: "檔案系統之檔案名稱");
```