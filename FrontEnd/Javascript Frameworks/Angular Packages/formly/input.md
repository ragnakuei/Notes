
```ts
  fields: FormlyFieldConfig[] = [
    {
      type: 'form-group',
      templateOptions: { flexDirection: 'horizontal' },
      fieldGroup: [
        {
          key: 'id',
          type: 'autocomplete',
          templateOptions: {
            placeholder: '請輸入員工編號',
            required: true,

            // 每次 key in 都會執行
            filter: (term: string) =>{
              console.log('term',term);
              return of([1,2,3]);
            },

            // blur input 才會執行
            change: (field, $event)=>{
              console.log($event);
            }
          },
        },
        {
          key: 'roleId',
          type: 'select',
          defaultValue: '',
          templateOptions: {
            options: this.rolesOptions$,
            required: true,
          },
        }
      ],
    },
  ]
```


```ts
this.formControl.valueChanges
      .pipe(
        takeUntil(this._unsubscribeAll),
        startWith(''),
        debounceTime(100),
        tap( () => {
          this.isLoading = true
        } ),
        switchMap( term => this.to.filter(term) )
      ).subscribe( (val) => {
          // if (!val) {
          //   return null;
          // }
          this.filter = val;
          this.isLoading = false;
      });
```