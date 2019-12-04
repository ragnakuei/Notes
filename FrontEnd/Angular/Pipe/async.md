# async

要使用 async 的資料流，必須是 Observable\<T> 的資料型態

```typescript
public customerAsyncOptions: Observable<CustomerOption[]>;

this.orderForm
    .get("CustomerID")
    .valueChanges.pipe(
    debounceTime(300),
    tap(val => {
        console.log("keyword:" + val);
    })
    )
    .subscribe(inputKeyword => {
    this.customerAsyncOptions = this.optionsService.getCusomers(inputKeyword);
    });
```

```html
<mat-autocomplete
    #customerAutoComplete="matAutocomplete"
    [displayWith]="displayCustomer"
>
<mat-option
    *ngFor="let customerOption of customerAsyncOptions | async"
    [value]="customerOption.CompanyName"
>
    <span
    innerHTML="{{ highlightFiltered(customerOption.CompanyName) }}"
    ></span>
</mat-option>
</mat-autocomplete>
```