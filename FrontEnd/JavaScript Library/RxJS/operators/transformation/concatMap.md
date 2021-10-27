# [concatMap](https://rxjs.dev/api/operators/concatMap)


#### 每個 Observable item 中間插複一個 delay

```js
of(1,2,3)
.pipe(concatMap(x => of(x).pipe(delay(500))))
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```
