# regexValidation.md

錯誤訊息可顯示

> 驗証是否符合 yyyy/MM/dd 

```ts
fields: FormlyFieldConfig[] = [
    {
        key: 'testDate',
        type: 'input',
        templateOptions: {
            label: 'Test Date',
            description: 'format: yyyy/mm/dd',
            required: true,
            validators: {
            testDate: {
                expression: (c : FormControl) => /^\d{4}\/\d{2}\/\d{2}$/.test(c.value),
                message: (error : any, field: FormlyFieldConfig) => `"${field.formControl?.value}" is not a valid testDate format`,
            },
        },
    },
]
```
