# resetModel


```html
<form [formGroup]="formlyService.form">
  <formly-form
    [form]="formlyService.form"
    [fields]="formlyService.fields"
    [options]="formlyService.options"
    [model]="formlyService.model"
  ></formly-form>

    <!-- ... -->

</form>
```

```js
export class FormlyService {
  form: FormGroup = new FormGroup({});
  model: FormlyModel = {
    name: '',
  };
  options: FormlyFormOptions = {};
  fields: FormlyFieldConfig[] = [
    {
      type: 'form-group',
      templateOptions: { flexDirection: 'horizontal' },
      fieldGroup: [
        {
          key: 'name',
          type: 'input',
          templateOptions: {
            label: 'TEAMS_MAPPING.TEAMS.FORM.NAME',
            placeholder: '請輸入名稱',
            required: true,
          },
        },
      ],
    },
  ];

  // ...

  resetModel() {
    this.options?.resetModel!();
  }
}


```