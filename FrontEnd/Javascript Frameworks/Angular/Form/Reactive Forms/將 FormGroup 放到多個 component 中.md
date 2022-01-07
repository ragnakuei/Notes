# 將 FormGroup 放到多個 component 中

---

Q：將 FormGroup 放到多個 component 中時，其他 component 經過動態 增加/刪除 FormControl 時，會發生無法立即顯示 FormGroup 的 validate error status !

A： 解法

在 submit 時，直接以 FormGroup.markAllAsTouched() 就可以解決這個問題了 !

```ts
submit(): void {

    this.formlyService.form.markAllAsTouched();

    if(this.formlyService.form.invalid) {
        return;
    }

    // TODO：continue submit flow !
}
```