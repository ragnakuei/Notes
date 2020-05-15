# FormBuilder

## 從 Response 轉成 FormGroup + FormArray

```typescript
ngOnInit() {
    this.route.params
        .subscribe(
            (params: Params) => {
                this.id = params['id'];
                this.orderService.getOrder(this.id)
                    .subscribe(
                        responseOrder => {
                            this.orderForm = this.formBuilder.group(
                                {
                                    OrderID: [{
                                        value: responseOrder.OrderID,
                                        disabled : true
                                    }],
                                    CustomerID: [responseOrder.CustomerID, Validators.required],
                                    EmployeeID: [responseOrder.EmployeeID],
                                    Details: this.formBuilder.array(responseOrder.Details.map(detail => 
                                        this.formBuilder.group({
                                            ProductID: [detail.ProductID],
                                            UnitPrice: [detail.UnitPrice],
                                        })
                                    ))
                                });
                        },
                        err => console.log('Error', err));
            }
        );
}
```

---

## FormControl 的簡化寫法

因為用了 Reactive Form 之後，原本的 html attribute 就只能透過 FormControl 來給定

```typescript
this.orderForm = this.formBuilder.group(
                {
                    OrderID: [{
                        value: responseOrder.OrderID,
                        disabled : true
                    }],
                    CustomerID: [responseOrder.CustomerID, Validators.required],    // 簡化寫法
                    CustomerID: new FormControl({                                   // 完整寫法
                        value: responseOrder.CustomerID
                    }, Validators.required),
                    EmployeeID: [responseOrder.EmployeeID],
                    Details: this.formBuilder.array(responseOrder.Details.map(detail => 
                        this.formBuilder.group({
                            ProductID: [detail.ProductID],
                            UnitPrice: [detail.UnitPrice],
                        })
                    ))
                });
```
