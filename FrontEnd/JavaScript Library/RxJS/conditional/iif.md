# [iif](https://rxjs.dev/api/index/function/iif)


```js
import { mergeMap } from 'rxjs/operators';
import { of, iif } from 'rxjs';

const source = of(1, 2, 3, 4, 5)
  .pipe(
    mergeMap( v =>
      iif(() => v % 2 === 0,
        of('是 2 的倍數'),
        of('不是 2 的倍數'),
      )
    )
  )
  .subscribe(
    (val) => console.log(val),
    (err) => console.log(err),
    () => console.log('complete')
  );
```
