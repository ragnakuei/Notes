# ngIf else 實作

注意：
- else 是 false 
- then 是 true

```html
<ng-container *ngIf="isUpdate; else createBlock ; then updateBlock " ></ng-container>
<ng-template #updateBlock>
    
</ng-template>
<ng-template #createBlock>
    
</ng-template>
```