 # [mergeScan](https://rxjs.dev/api/operators/mergeScan)

- 跟 reduce / scan 類似
- 將回傳值 Observable\<T> 取出 T 後，做為下一次的 acc

```js
mergeScan<T, R>(accumulator: (acc: R, value: T, index: number) => ObservableInput<R>, 
                seed: R, 
                concurrent: number = Infinity
): OperatorFunction<T, R>
```


#### 範例

- reduce 不需要將回傳結果包裝成 Observable，但是 mergeScan 要

```js
import { of, range } from 'rxjs';
import { mergeMap, groupBy, reduce, map, concatMap, exhaustMap, switchMap, mapTo, mergeScan } from 'rxjs/operators';

range(1,10)
  .pipe(
    mergeScan( (acc, value, index) => of(acc + value), 0 )
  )
  .subscribe({
    next: (val) => console.log(val),
    complete: () => console.log('complete'),
    error: (err) => console.log(err),
  });
```

