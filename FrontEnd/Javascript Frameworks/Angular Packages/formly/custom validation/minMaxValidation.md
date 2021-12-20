# minMaxValidation

待解決：錯誤訊息無法顯示 !

app.module.ts
```ts
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { FormlyModule } from '@ngx-formly/core';
import { FormlyMaterialModule } from '@ngx-formly/material';
import { FormlyMatDatepickerModule } from '@ngx-formly/material/datepicker';
import { FormlyMatToggleModule } from '@ngx-formly/material/toggle';
import { formlyModuleConfig } from '@shared-lib/options/formly.option';

import { ComponentsModule } from '@shared-lib/components/components.module';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

@NgModule({
  declarations: [AppComponent],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    HttpClientModule,

    FormlyModule.forRoot({
            types: [
                {
                    name: 'form-group',
                    component: FormlyFormGroup,
                },
                {
                    name: 'radio',
                    component: FormlyFieldRadio,
                    wrappers: [ 'label-wrapper', 'form-field' ],
                },
                {
                    name: 'select',
                    component: FormlyFieldSelect,
                    wrappers: [ 'label-wrapper', 'form-field' ],
                },
            ],
            wrappers: [
                { name: 'label-wrapper', component: LabelWrapperComponent },
                { name: 'date-range-wrapper', component: DateRangeWrapperComponent },
            ],
            validators: [
                // 註冊 validator 
                { name: 'minMax', validation: minMaxValidator },
            ],
            validationMessages: [
                { name: 'required', message: 'This field is required' },

                // 註冊 validator 顯示錯誤訊息
                { name: 'minMax', message: minMaxValidatorMessage },
            ],
            extras: { lazyRender: true },
        }),

    // ...
    ComponentsModule,
    AppRoutingModule,
  ],
  providers: [
    // ...
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
```


minMaxValidator
```ts
import { AbstractControl, ValidationErrors } from '@angular/forms';

import { FormlyFieldConfig } from '@ngx-formly/core';

export function minMaxValidator(control: AbstractControl,
                                field: FormlyFieldConfig,
                                options?: {
                                  [id: string]: any;
                                }): ValidationErrors | null {

  let maxValue = parseInt(field?.templateOptions?.maxValue);
  let minValue = parseInt(field?.templateOptions?.minValue);
  let curValue = parseInt(control.value);

  // 物件名稱要與目前的一致
  // 回傳 null 值代表驗証通過
  let validationResult: { minMaxValidator: boolean } = { minMaxValidator: true };

  if(curValue <= maxValue && curValue >= minValue) {
    return null;
  }

  console.log('minValue', minValue);
  console.log('maxValue', maxValue);
  console.log('curValue', curValue);

  console.log('validationResult', validationResult);

  return validationResult;
}
```


minMaxValidatorMessage
```ts
export function minMaxValidatorMessage(err : any, field: FormlyFieldConfig): string {
  return 'This field is not in RANGE';
}
```