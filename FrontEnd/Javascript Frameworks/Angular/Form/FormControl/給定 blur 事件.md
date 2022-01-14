# 給定 blur 事件


```ts
const userNameFormControl = new FormControl(null, {
    validators : Validators.required,
    updateOn: 'blur'
});
userNameFormControl.valueChanges.subscribe(value => {
    alert('userName changes');
})
```