# 動態增加刪除 FormArray item

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
    this.formOptionIds.push(this.formBuilder.control('', Validators.required));
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