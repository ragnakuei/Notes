# RenameColumn

更改欄位名稱，其餘不動

## 範例

```csharp
migrationBuilder.RenameColumn(
    name: "AuditingPerson",
    table: "WorkServiceOrderOffer",
    newName: "AuditingPersonGuid",
    schema: "dbo" );
```