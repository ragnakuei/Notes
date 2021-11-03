# [switchMapTo](https://rxjs.dev/api/operators/switchMapTo)

```js
switchMapTo<T, R, O extends ObservableInput<unknown>>(
    innerObservable: O, 
    resultSelector?: (outerValue: T, 
                      innerValue: ObservedValueOf<O>, 
                      outerIndex: number, 
                      innerIndex: number) => R
): OperatorFunction<T, ObservedValueOf<O> | R>
```


#### 範例

```html
<script src="https://unpkg.com/rxjs@^7/dist/bundles/rxjs.umd.min.js"></script>
<button id="btn">執行</button>
<script>
    const { fromEvent, interval } = rxjs;
    const { switchMapTo, exhaustMap, switchMap } = rxjs.operators;

    const btn = document.getElementById('btn');
    
    fromEvent(btn, 'click')
    .pipe(
        // 無法重新被觸發
        // exhaustMap( 
        //   (v, i) => interval(1000),
        //   (v1, v2, i1, i2) => `value 1:${v1} value 2:${v2} index 1:${i1} index 2:${i2}`
        // )
        
        // 可以重新被觸發，按下的 click 可以被累計 index (click 按幾次)
        // switchMap( 
        //   (v, i) => interval(1000),
        //   (v1, v2, i1, i2) => `value 1:${v1} value 2:${v2} index 1:${i1} index 2:${i2}`
        // )
        
        // 可以重新被觸發，按下的 click 可以被累計 index (click 按幾次)
        switchMapTo(interval(1000),
                    (v1, v2, i1, i2 ) => `v1:${v1} v2:${v2} i1:${i1} i2:${i2}` )
    )
    .subscribe({
        next: (val) => console.log(val),
        complete: () => console.log('complete'),
        error: (err) => console.log(err),
    });
</script>
```