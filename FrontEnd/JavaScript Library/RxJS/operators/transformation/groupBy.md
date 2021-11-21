# [groupBy](https://rxjs.dev/api/operators/groupBy)


```js
groupBy<T, K, R>(keySelector: (value: T) => K, 
        elementOrOptions?: void | ((value: any) => any) | BasicGroupByOptions<K, T> | GroupByOptionsWithElement<K, R, T>, 
        duration?: (grouped: GroupedObservable<any, any>) => ObservableInput<any>, 
        connector?: () => SubjectLike<any>
    ): OperatorFunction<T, GroupedObservable<K, R>>
```

#### 範例 回傳 key value: array

```js
import { of } from 'rxjs';
import { mergeMap, groupBy, reduce, toArray } from 'rxjs/operators';

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
        value: await group$
                      .pipe(toArray())
                      // 用這個也可以，但是 toArray() 比較簡潔直接 !
                      // .pipe(reduce((acc, cur) => [...acc, cur], []))
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

next 會以每個 group 進行輸出