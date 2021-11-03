# [map](https://rxjs.dev/api/operators/map)

##### 範例

```js
of(1,2,3,4,5)
.pipe(map(v => v + 10))
.subscribe(
  (val) => console.log(val),
  (err) => console.log(err),
  () => console.log('complete')
);
```

等於是 concatMap / mergeMap

```js
of( 1,2,3,4,5 )
  .pipe(
    concatMap( v => of(v + 10))
  )
  .subscribe({
    next: (val) => console.log(val),
    complete: () => console.log('complete'),
    error: (err) => console.log(err),
  });
```
