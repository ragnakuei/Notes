# 動態增加刪除 FormArray item

### FormControl 套用 select multiple

```ts
this.form = new FormGroup({
  name: new FormControl(dayOffType?.code, [ Validators.required ]),
  courseIds: new FormControl(courseIds, [ Validators.required ]),
});
```

```html
<mat-select formControlName="courseIds" multiple>
  <mat-option
    *ngFor="let course of courseService.list$ | async"
    [value]="course.id"
  >
    {{ course.name }}
  </mat-option>
</mat-select>
```

### FormArray 的 item 為字串

#### script

```ts
import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from "@angular/forms";
import { Option } from "./models/option";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: [ './app.component.scss' ]
})
export class AppComponent implements OnInit {
  title = 'angular-practice';
  orderForm!: FormGroup;
  options!: Array<Option>;

  constructor(
    private formBuilder: FormBuilder
  ) {
  }

  ngOnInit() {
    this.orderForm = this.formBuilder.group({
      OrderId: [ '', Validators.required ],
      OptionIds: this.formBuilder.array([
        this.formBuilder.control(null, Validators.required)
      ])
    });

    this.options = [
      { text: "A", value: 1 },
      { text: "B", value: 2 },
      { text: "C", value: 3 },
    ];
  }

  get formOptionIds(): FormArray {
    return this.orderForm.get('OptionIds') as FormArray;
  }

  addFormOptionId() {
    this.formOptionIds.push(this.formBuilder.control(null, Validators.required));
  }

  removeFormOptionId(index : number) {
    this.formOptionIds.removeAt(index);
  }

  onSubmit() {
    console.log(this.orderForm);
  }
}

```

#### template

重點：
- binding 至 formGroup.FormArray
  - 給定 `formArrayName="OptionIds"`
    - 跟給定 `formControlName` 相同原理
  - 給定 `[formControlName]="i"`

```html
<form [formGroup]="orderForm"
      (ngSubmit)="onSubmit()">
  <div>
    <label for="orderId"></label>
    <input type="text"
           id="orderId"
           formControlName="OrderId" />
  </div>

  <div formArrayName="OptionIds"
       *ngFor="let optionId of formOptionIds.controls; let i = index;">
    <select [formControlName]="i">
      <option [ngValue]="null"
              disabled
              selected>請選擇
      </option>
      <option *ngFor="let option of options"
              [value]="option.value">
        {{ option.text }}
      </option>
    </select>
    <button *ngIf="formOptionIds.controls.length > 1"
            (click)="removeFormOptionId(i)">del
    </button>
    <label>valid:{{ formOptionIds.controls[i].valid}}</label>&nbsp;
    <label>touched:{{ formOptionIds.controls[i].touched}}</label>&nbsp;
    <label>dirty:{{ formOptionIds.controls[i].dirty}}</label>&nbsp;
    <label *ngIf="formOptionIds.controls[i].touched && formOptionIds.controls[i].errors?.['required']"
           style="color: red">
      請選擇項目 !
    </label>
  </div>

  <div>
    <button (click)="addFormOptionId()">Add Option</button>
  </div>
  <div>
    <button type="submit"
            [disabled]="orderForm.invalid">Submit
    </button>
  </div>
</form>

<div>
  <div>Result:{{ orderForm.value | json }}</div>
  <div>Valid:{{ orderForm.valid | json }}</div>
</div>
```

### FormArray 的 item 為物件

#### script

```ts
import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from "@angular/forms";
import { Option } from "./models/option";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: [ './app.component.scss' ]
})
export class AppComponent implements OnInit {
  title = 'angular-practice';
  orderForm!: FormGroup;
  options!: Array<Option>;

  constructor(
    private formBuilder: FormBuilder
  ) {
  }

  ngOnInit() {
    this.orderForm = this.formBuilder.group({
      OrderId: [ '', Validators.required ],
      Dtos: this.formBuilder.array([
        this.generateFormDto(),
      ])
    });

    this.options = [
      { text: "A", value: 1 },
      { text: "B", value: 2 },
      { text: "C", value: 3 },
    ];
  }

  get formDtos(): FormArray {
    return this.orderForm.get('Dtos') as FormArray;
  }

  addFormDto() {
    this.formDtos.push(this.generateFormDto());
  }

  removeFormOption(index : number) {
    this.formDtos.removeAt(index);
  }

  private generateFormDto(): FormGroup {
    return this.formBuilder.group({
      name: [ '', Validators.required ],
      type: [ '', Validators.required ],
    })
  }

  onSubmit() {
    console.log(this.orderForm);
  }
}

```

#### template

- tr > td 之間，靠 `ng-container` 來指定 formGroupName

```html
<form [formGroup]="orderForm"
      (ngSubmit)="onSubmit()">
  <div>
    <label for="orderId"></label>
    <input type="text"
           id="orderId"
           formControlName="OrderId" />
  </div>

  <table>
    <thead>
    <tr>
      <th>名稱</th>
      <th>類型</th>
      <th>
        <button type="button" (click)="addFormDto()">Add Dto</button>
      </th>
    </tr>
    </thead>
    <tbody>
    <tr formArrayName="Dtos"
        *ngFor="let dto of formDtos.controls; let i = index;">
      <ng-container [formGroupName]="i">
        <td>
          <input type="text"
                 formControlName="name" />
          <label *ngIf="dto.get('name')?.touched
                     && dto.get('name')?.errors?.['required']"
                 style="color: red">
            請輸入名稱 !
          </label>
        </td>
        <td>
          <select formControlName="type">
            <option [ngValue]="null"
                    disabled
                    selected>請選擇
            </option>
            <option *ngFor="let option of options"
                    [value]="option.value">
              {{ option.text }}
            </option>
          </select>
          <label *ngIf="dto.get('type')?.touched
                     && dto.get('type')?.errors?.['required']"
                 style="color: red">
            請選擇項目 !
          </label>
        </td>
        <td>
          <button *ngIf="formDtos.controls.length > 1"
                  (click)="removeFormOption(i)">del
          </button>
        </td>
      </ng-container>
    </tr>
    </tbody>
  </table>
  <div>
    <button type="submit"
            [disabled]="orderForm.invalid">Submit
    </button>
  </div>
</form>

<div>
  <div>Result:{{ orderForm.value | json }}</div>
  <div>Valid:{{ orderForm.valid | json }}</div>
</div>
```
