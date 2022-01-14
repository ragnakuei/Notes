# Validators 變更.md

[參考資料](https://stackoverflow.com/questions/38797414/in-angular-how-to-add-validator-to-formcontrol-after-control-is-created)


FormControl 有以下 method 可以對 Validators 操作

- addValidators()
- setValidators()
- removeValidators()
- clearValidators()
- 上述所有項目的非同步版本

上述只要有變更後，都要記得額外執行 updateValueAndValidity() 才能確保更新狀態 !

另外：

template 中，如果以 

```html
<input [FormControl]='formControl'>
```

```ts
get formControl() : FormControl() {
    // ...
}
```
可能會 binding 失敗 !
