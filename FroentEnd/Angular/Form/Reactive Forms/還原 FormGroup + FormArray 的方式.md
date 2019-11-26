# 還原 FormGroup + FormArray 的方式

```typescript
  changeToReadOnlyMode() {

    // FormGroup 可直接以 reset() 再給定初值的方式處理
    this.orderForm.reset(this.order);

    const detailFormArray = (this.orderForm.get("Details") as FormArray);
    detailFormArray.clear();

    // FormArray 就必需重新再給定值
    for(var detail of this.order.Details)
    {
        detailFormArray.push(this.formBuilder.group({
            ProductID: [detail.ProductID],
            UnitPrice: [detail.UnitPrice],
            Quantity: [detail.Quantity],
            Discount: [detail.Discount]
          }));
    }

    this.isReadOnly = true;
  }
```
