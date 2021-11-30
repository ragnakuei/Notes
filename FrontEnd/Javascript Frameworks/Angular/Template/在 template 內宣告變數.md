# 在 template 內宣告變數

https://newbedev.com/how-to-declare-a-variable-in-a-template-in-angular

#### 方式一

意圖：在 \*ngIf 內，將 seasonIndex + 4 assign 為 groupIndex

缺點

-   \*ngIf=0 將不會顯示

```html
<ng-container
    *ngIf="seasonIndex + 4 as groupIndex"
    [formGroupName]="groupIndex"
>
</ng-container>
```
