# select

- [Bind Observables to Select](https://formly.dev/examples/other/observable-select)

## 範例一

```ts
interface Option {
  value: string | null,
  label: string | null,

  // 讓該 option 為 disabled 狀態
  disabled: boolean,
}

@Injectable({
  providedIn: 'root'
})
export class AssignRoleFormlyService {
  rolesOptions$ = new BehaviorSubject<Option[]>([]);

  constructor(
    private roleService: RoleService,
  ) {
    this.getRolesOptions();
  }

  form: FormGroup = new FormGroup({});
  model!: FormlyModel;
  options: FormlyFormOptions = {};
  fields: FormlyFieldConfig[] = [
    {
      type: 'form-group',

      // 控制項水平排列
      templateOptions: { flexDirection: 'horizontal' },
      fieldGroup: [
        {
          key: 'id',
          type: 'input',
          templateOptions: {
            placeholder: '請輸入員工編號',
            required: true,
          },
        },
        {
          key: 'roleId',
          type: 'select',

          // 給定預設值
          defaultValue: '',
          templateOptions: {
            options: this.rolesOptions$,
            required: true,
          },
        }
      ],
    },
  ]

  getRolesOptions(): void {
    this.roleService.getRoles()
        .subscribe((response) => {
          const roles = response.results.map((role) => this.createOption(role.id, role.name));

          // 給定預設選項，value 對應預設值
          roles.splice(0, 0, this.createOption('', '請選擇角色', true));

          this.rolesOptions$.next(roles);
        });
    ;
  }

  createOption(value: string | null, text: string | null, disabled = false): Option {
    return { value, label: text, disabled };
  }
}
```