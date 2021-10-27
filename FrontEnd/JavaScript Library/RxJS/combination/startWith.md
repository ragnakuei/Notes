# [startWith](https://rxjs.dev/api/operators/startWith)

在原本的 Observable 前面插入 item

```js
of(1)
.pipe(startWith(2))
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```
