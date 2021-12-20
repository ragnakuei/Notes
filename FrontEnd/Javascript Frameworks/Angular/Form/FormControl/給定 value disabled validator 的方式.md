# 給定 value disabled validator 的方式

```ts
this.form = this.formBuilder.group({
    typeId: [this.type?.id , [Validators.required]],
    codes: this.formBuilder.array([]),
});

if(this.isUpdate){
    this.form.controls['typeId'].disable();
}
```

[參考資料](https://stackoverflow.com/questions/42840136/disable-input-fields-in-reactive-form/47521965)