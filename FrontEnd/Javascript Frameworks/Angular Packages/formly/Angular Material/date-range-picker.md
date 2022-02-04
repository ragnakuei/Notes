# date-range-picker


```ts
import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { FieldWrapper } from '@ngx-formly/core';

@Component({
  selector: 'shared-lib-formly-wrapper-mat-date-range',
  template: `
    <mat-form-field [formGroup]="form">
      <mat-date-range-input
        [rangePicker]="dateRangePicker"
        [min]="field.templateOptions?.minDate"
        [max]="field.templateOptions?.maxDate"
      >
        <input
          matStartDate
          [placeholder]="
            field.fieldGroup![0]?.templateOptions?.placeholder ?? '' | translate
          "
          [formControlName]="getFormControlName(0)"
          #dateRangeStart
        />
        <input
          matEndDate
          [placeholder]="
            field.fieldGroup![1]?.templateOptions?.placeholder ?? '' | translate
          "
          [formControlName]="getFormControlName(1)"
          #dateRangeEnd
          (dateChange)="dateRangeChange(dateRangeStart, dateRangeEnd)"
        />
      </mat-date-range-input>
      <mat-datepicker-toggle matSuffix [for]="dateRangePicker">
      </mat-datepicker-toggle>
      <mat-date-range-picker #dateRangePicker></mat-date-range-picker>
      <mat-error
        *ngIf="
          isRequiredStart &&
          hasRequiredErrors(getFormControlName(0)) &&
          getFormControl(getFormControlName(0))?.touched
        "
      >
        This field {{ getFormControlName(0) }} is required
      </mat-error>
      <mat-error
        *ngIf="
          getFormControl(getFormControlName(0))?.hasError('matDatepickerParse')
        "
        >Invalid {{ getFormControlName(0) }}</mat-error
      >
      <mat-error
        *ngIf="
          isRequiredEnd &&
          hasRequiredErrors(getFormControlName(1)) &&
          getFormControl(getFormControlName(1))?.touched
        "
      >
        This field {{ getFormControlName(1) }} is required
      </mat-error>
      <mat-error
        *ngIf="
          getFormControl(getFormControlName(1))?.hasError('matDatepickerParse')
        "
        >Invalid {{ getFormControlName(1) }}</mat-error
      >
    </mat-form-field>
  `,
  styles: [
    `
      ::ng-deep shared-lib-formly-wrapper-mat-date-range {
        width: 100%;

        mat-form-field {
          width: 100%;
        }
      }
    `,
  ],
})
export class MatDateRangeWrapperComponent
  extends FieldWrapper
  implements OnInit
{
  ngOnInit(): void {}

  get isRequiredStart(): boolean {
    return this.field.fieldGroup![0]?.templateOptions?.required ?? false;
  }

  get isRequiredEnd(): boolean {
    return this.field.fieldGroup![1]?.templateOptions?.required ?? false;
  }

  getFormControlName(index: number): string {
    const key = <string>this.field.fieldGroup![index]?.key;
    return key;
  }

  getFormControl(key: string): FormControl {
    const formControl = this.form.get(key) as FormControl;
    return formControl;
  }

  hasRequiredErrors(key: string): boolean {
    const formControl = this.form.get(key) as FormControl;

    const hasRequiredError = formControl.hasError('required');
    const hasParseError = formControl.hasError('matDatepickerParse');

    if (hasParseError) {
      return false;
    }

    return hasRequiredError;
  }

  dateRangeChange(
    dateRangeStart: HTMLInputElement,
    dateRangeEnd: HTMLInputElement,
  ) {
    if (this.field.templateOptions?.dateRangeChange) {
      this.field.templateOptions?.dateRangeChange(dateRangeStart, dateRangeEnd);
    }
  }
}
```