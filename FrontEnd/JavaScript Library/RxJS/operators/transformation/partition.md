# [partition](https://rxjs.dev/api/index/function/partition)

- 把 Observable\<T> 拆成 Observable\<T>[]


#### 範例

```js
import { of, range, partition } from 'rxjs';
import { mergeMap, groupBy, reduce, map, concatMap, exhaustMap, switchMap, mapTo, mergeScan } from 'rxjs/operators';


let [event$, odd$] = partition( 
  range(1,10),
  (value, index) => value % 2 === 0 
);

let subscribeOption = {
  next: (val) => console.log(val),
  complete: () => console.log('complete'),
  error: (err) => console.log(err),
};

event$.subscribe(subscribeOption);
odd$.subscribe(subscribeOption);
```