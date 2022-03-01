# 凍結 header

- 在 `matHeaderRowDef` 後方加上 `sticky: true`

```html
<table mat-table [dataSource]="dataSource" matSort>
    <tr mat-header-row *matHeaderRowDef="displayedColumns; sticky: true"></tr>
    <tr
        mat-row
        *matRowDef="let row; columns: displayedColumns; let i = index"
        [class]="baseOverdueAnnualLeaveService.rowClass(row)"
    ></tr>
</table>
```
