# [mergeMap](https://rxjs.dev/api/operators/mergeMap) / [flatMap](https://rxjs.dev/api/operators/flatMap)

- flatMap 在 v8 時，會 rename 成 mergeMap
- 將 Observable\<T> 給解開成 T 給 Subscribe.Next
- 也會拆解 Array\<T> 為 T
- 跟 exhaustMap 類似

```js
mergeMap<T, R, O extends ObservableInput<any>>(
    project: (value: T, index: number) => O, 
    resultSelector?: number | ((outerValue: T, 
                                innerValue: ObservedValueOf<O>, 
                                outerIndex: number, 
                                innerIndex: number) => R), 
    concurrent: number = Infinity
): OperatorFunction<T, ObservedValueOf<O> | R>
```


#### 範例

- 如果改用 exhaustMap 只會回傳第一筆資料
- 如果改用 switchMap 只會回傳最後一筆資料

```js
import { of } from 'rxjs';
import { mergeMap, groupBy, reduce, map, concatMap, exhaustMap } from 'rxjs/operators';

of(
  { id: 1, name: 'JavaScript' },
  { id: 2, name: 'Parcel' },
  { id: 2, name: 'webpack' },
  { id: 1, name: 'TypeScript' },
  { id: 3, name: 'TSLint' }
)
  .pipe(
    groupBy((p) => p.id),
    mergeMap( async (group$) => {
      return {
        key: group$.key,
        value: await group$.pipe(reduce((acc, cur) => [...acc, cur], []))
                           .toPromise()
      };
    })
  )
  .subscribe({
    next: (val) => console.log(val),
    complete: () => console.log('complete'),
    error: (err) => console.log(err),
  });
```
