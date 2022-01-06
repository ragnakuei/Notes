# RadioButton ngFor Binding 後就被 Lock

```ts
import { Component } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

@Component({
    selector: 'radio-ng-model-example',
    templateUrl: 'radio-ng-model-example.html',
    styleUrls: ['radio-ng-model-example.css'],
})
export class RadioNgModelExample {
    form = new FormGroup({});

    // 這樣就會被 lock
    get options(): any[] {
        return [
            { value: false, label: 'false' },
            { value: true, label: 'true' },
        ];
    }

    constructor() {
        this.form.setControl('selectResult', new FormControl(null));
    }
}
```

```html
<form [formGroup]="form" (ngSubmit)="save()">
    <mat-radio-group formControlName="selectResult">
        <mat-radio-button *ngFor="let option of options" [value]="option.value"
            >{{ option.label }}</mat-radio-button
        >
    </mat-radio-group>
</form>
<div>{{ form.get('selectResult')?.value }}</div>
```

### 解法

> 不要用 get property

#### 解法一

```ts
// 這樣不會被 lock
options: any[] = [
    { value: false, label: 'false' },
    { value: true, label: 'true' },
];
```

#### 解法二

- setTimeout 請依照情況判斷，非必要 !

```ts
yesNoOptions$ = new BehaviorSubject<any[]>([]);

getYesNoOptions(): void {
    Observable.create(() => {
        // setTimeout(() => {
            this.options$.next([
                { value: true, label: '是') },
                { value: false, label: '否') },
            ]);
        // }, 0);
    }).subscribe();
}
```

```html
<form [formGroup]="form" (ngSubmit)="save()">
    <mat-radio-group formControlName="selectResult">
        <mat-radio-button *ngFor="let option of options$ | async" [value]="option.value"
            >{{ option.label }}</mat-radio-button
        >
    </mat-radio-group>
</form>
<div