# ngIf else 做法

## 方式一
- then 後方一定要加 ;
- then else 都是接 ng-template 的 template reference

```html
<ng-container *ngIf="row === editPerson; then viewBlock; else editBlock">
</ng-container>
<ng-template #viewBlock>
    <button mat-raised-button color="primary" (click)="submitEdit(row)" >送出</button>
    <button mat-raised-button color="warn" (click)="cancelEdit()">取消</button>
</ng-template>
<ng-template #editBlock>
    <button mat-raised-button color="primary" (click)="edit(row)" >編輯</button>
    <button mat-raised-button color="warn">刪除</button>
</ng-template>
```
