# plain-text

#### 注意事項

- 顯示資料用
- boolean 為 false 不會顯示資料
- 這個方式不要與 編輯 form 混用

#### 特殊條件
1. 需要實作 hook onChanges

    ```ts
    export const hookOnChanges: FormlyLifeCycleOptions<FormlyHookFn> = {
      onChanges: (field) => {
        if (field?.formControl?.value) {
          field.templateOptions!.value = field.formControl.value;
        }
      },
    };
    ```

1. fields 要以 get 方式回傳，不要用 public field

    ```
    注意：編輯 form 時，就要用 public field
    ```

    ```ts
    public form: FormGroup = new FormGroup({});
    public model!: FormlyModel;
    public options: FormlyFormOptions = {};
    public get fields(): FormlyFieldConfig[] {
        return [{
            type: 'form-group',
            fieldGroup: [
            {
                key: 'name',
                type: 'plain-text',
                templateOptions: {
                    label: 'name',
                    isNotInput: true,
                },
                hooks: hookOnChanges,
            },
            ]
        }];
    }
    ```

1. 只需要把 value assign 給 model 就可以了 !