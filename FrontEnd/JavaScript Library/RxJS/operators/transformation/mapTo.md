# [mapTo](https://rxjs.dev/api/operators/mapTo)

- 轉成固定的輸出值

#### 範例

```js
of( 1,2,3,4,5 )
  .pipe(
    mapTo(10)
  )
  .subscribe({
    next: (val) => console.log(val),
    complete: () => console.log('complete'),
    error: (err) => console.log(err),
  });
```

輸出結果

```
10
10
10
10
10
complete
```