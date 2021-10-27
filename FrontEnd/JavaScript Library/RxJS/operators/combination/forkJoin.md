# [forkJoin](https://rxjs.dev/api/index/function/forkJoin)

把所有的 Observable 執行完畢後，放入 Collection / Dictionary 中

- 放入 Collection 中

    ```js
    import { of, iif, interval, timer, combineLatest, concat, forkJoin } from 'rxjs';
    import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith } from 'rxjs/operators';

    forkJoin(
        of('Hello'),
        of('World').pipe(delay(2000))
    )
    .subscribe(
        (val) => console.log(val),
        (err) => console.log(err),
        () => console.log('complete')
    );
    ```

- 放入 Dictionary 中
  要傳入 object

    ```js
    import { of, iif, interval, timer, combineLatest, concat, forkJoin } from 'rxjs';
    import { delay, combineAll, map, mergeMap, sequenceEqual, take, concatAll, startWith, endWith } from 'rxjs/operators';

    forkJoin({
        1 : of('Hello'),
        2 : of('World').pipe(delay(2000))
    })
    .subscribe(
        (val) => console.log(val),
        (err) => console.log(err),
        () => console.log('complete')
    );
    ```
