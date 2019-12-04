# [Autocomplete](https://material.angular.io/components/autocomplete/api)

> import {MatAutocompleteModule} from '@angular/material/autocomplete';

---

## displayWith 範例

### 注意事項

- [displayWith] 所指定的 method 中，雖然語法沒有問題，但是實際執行時，會抓不到該 Component 內的 Property 資料。
- [displayWith] 給定的參數是 option 內的 [value]

### 範例

```html
<form [formGroup]="orderForm" (ngSubmit)="onSubmit(orderForm.value)">
  <mat-autocomplete
    #customerAutoComplete="matAutocomplete"
    (optionSelected)="onCustomerOptionChanged($event)"
    [displayWith]="displayCustomer"
  >
    <mat-option
      *ngFor="let customerOption of customerOptions"
      [value]="customerOption"
    >
      <span
        innerHTML="{{ customerOption.CompanyName }}"
      ></span>
    </mat-option>
  </mat-autocomplete>
  <form></form>
</form>
```

```typescript
import { MatAutocompleteModule } from "@angular/material/autocomplete";

public orderForm: FormGroup;
public customerOptions: CustomerOption[] = [];

public ngOnInit() {
this.orderForm = new FormGroup({
    CustomerID: new FormControl(""),
    Details: new FormArray([]),
    EmployeeID: new FormControl(""),
    Freight: new FormControl(""),
    OrderDate: new FormControl(""),
    RequiredDate: new FormControl(""),
    ShipAddress: new FormControl(""),
    ShipCity: new FormControl(""),
    ShipCountry: new FormControl(""),
    ShipName: new FormControl(""),
    ShipPostalCode: new FormControl(""),
    ShipRegion: new FormControl(""),
    ShipVia: new FormControl(""),
    ShippedDate: new FormControl("")
});

this.orderForm
    .get("CustomerID")
    .valueChanges.pipe(
    debounceTime(300),
    tap(val => {
        console.log("keyword:" + val);
    })
    )
    .subscribe(inputKeyword => {

    // 因為 AutoComplete 在 (1)輸入時，跟 (2) 選擇 Option 時，都會觸發 valueChanges
    // 解決方式：剛好因為 Option 的 Value 改成 object，所以就透過型別的方式去阻擋第二次觸發
    if (typeof inputKeyword === "string") {
        this.optionsService.getCusomers(inputKeyword).subscribe(
        queryOptions => {
            this.customerOptions = queryOptions;
        },
        err => console.log("Error", err)
        );
    }
    });
}

public displayCustomer(customOption: CustomerOption): string {
    if (customOption) {
        return `${customOption.CustomerID} / ${customOption.CompanyName}`;
    } else {
        return "";
    }
}

public onSubmit(submitData: any) {

// 因為將 Option 的資料型態改成 Object
// 所以在 submit 時，就判斷該欄位如果是 object 時，就更新該欄位資料，再送給後端
// 如果不想處理這段，可以把後端改成接收 object 也是個不錯的做法。
if (typeof submitData.CustomerID === "object") {
    submitData.CustomerID = (submitData.CustomerID as CustomerOption).CustomerID;
}
this.orderService.createOrder(submitData).subscribe(
    val => {
    this.router.navigate(["/order/detail/" + val]);
    },
    err => console.log("Error", err)
);
}

public onCustomerOptionChanged(e: MatAutocompleteSelectedEvent) {

}
```

參考資料：

- [[Angular Material完全攻略] Day 10 - 打造問卷頁面(2) - Input、Autocomplete](https://ithelp.ithome.com.tw/articles/10194495)
- [Angular Material Autocomplete](https://hoshcoding.com/courses/1/angular-material-autocomplete)
