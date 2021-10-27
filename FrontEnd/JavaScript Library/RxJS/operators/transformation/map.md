# [map](https://rxjs.dev/api/operators/map)


```js
of(1,2,3,4,5)
.pipe(map(v => v + 10))
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```
