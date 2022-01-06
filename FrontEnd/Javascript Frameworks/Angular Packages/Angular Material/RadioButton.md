# RadioButton

```html
<form [formGroup]="formlyService.form" (ngSubmit)="save()">
    <mat-radio-group formControlName="isEventDayOff">
        <mat-radio-button
            *ngFor="let option of options$ | async"
            [value]="option.value"
            >{{ option.label }}</mat-radio-button
        >
    </mat-radio-group>
</form>
```
