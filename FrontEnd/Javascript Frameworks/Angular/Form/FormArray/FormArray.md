# FormArray

注意：
- FormArray 無法直接用於 form tag 中，必須加一層 FormGroup 才可以 !

### FormGroup 裡面有 FormArray 的寫法

```typescript
ngOnInit() {
    this.orderForm = this.fb.group({ });
    this.route.params
        .subscribe(
            (params: Params) => {
                this.id = params['id'];
                this.testService.getOrder(this.id)
                    .subscribe(
                        responseOrder => {
                            this.orderForm = this.fb.group(
                                {
                                    OrderID: [responseOrder.OrderID],
                                    Details: this.fb.array(responseOrder.Detail.map(detail =>
                                        this.fb.group({
                                            ProductID: [detail.ProductID],
                                            UnitPrice: [detail.UnitPrice],
                                            Quantity: [detail.Quantity],
                                            Discount: [detail.Discount],
                                        })
                                    )),
                                });
                        });
            }
        );
}

get detailFormGroups() {
    let result = (this.orderForm.get('Details') as FormArray).controls;
    console.log(result);
    return result;
}
```

template

```html
<form [formGroup]="orderForm" (ngSubmit)="onSubmit(orderForm.value)">
    <div><label for="OrderID"> OrderID </label> <input id="OrderID" type="text" formControlName="OrderID" readonly></div>

    <p>detail</p>
    <div formArrayName="Details" >
        <div *ngFor="let detail of this.orderForm.get('Details')?.controls; let detailIndex = index;"
            [formGroupName]="detailIndex">
                <div> <label for="ProductID"> ProductID </label> <input formControlName="ProductID"> </div>
                <div> <label for="UnitPrice"> UnitPrice </label> <input formControlName="UnitPrice"> </div>
                <div> <label for="Quantity"> Quantity </label> <input formControlName="Quantity"> </div>
                <div> <label for="Discount"> Discount </label> <input formControlName="Discount"> </div>
        </div>
    </div>
</form>
```

ngFor 那一行可改寫成

> 這個方式可以用來 debug ，避免 render html 時，會有不明確的錯誤訊息

```typescript
get detailFormGroups() {
    let result = (this.orderForm.get('Details') as FormArray).controls;
    console.log(result);
    return result;
}
```

```html
<div *ngFor="let detail of detailFormGroups; let detailIndex = index;"
```
