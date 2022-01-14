# 同時處理多個 request 的方式

### 同個 api  => 同資料類型

```html
<script src="https://unpkg.com/rxjs@^7/dist/bundles/rxjs.umd.min.js"></script>
<script>
    const { from, of, range, interval, concat, forkJoin,  } = rxjs;
    const { map, filter, repeat, take, delay  } = rxjs.operators;
   
    function createObservable(i) {
        
        if(i === 2 ) {
            return of(i).pipe(delay(5000));    
        }
        
        return of(i).pipe(delay(500));
    }
    
    forkJoin([
        createObservable(1),
        createObservable(2),
    ])
    .pipe(
        map(i => {
            console.log('1',i);
            return i;
        })
    ).subscribe((x) => console.log('2',x));
</script>
```



### 前二個 reqeust 幾乎平行跑，後面再串一個 request

- createObservable 視為模擬 request 的動作
- 傳入值為 1.2 為幾乎平行跑的
- 等上述執行完畢後
- 執行傳入值為 3

```html
<script src="https://unpkg.com/rxjs@^7/dist/bundles/rxjs.umd.min.js"></script>
<script>
    const { from, of, range, interval, concat, forkJoin,  } = rxjs;
    const { map, mergeMap, filter, repeat, take, delay  } = rxjs.operators;
   
    function createObservable(i) {
        return of(i).pipe(delay(500));
    }
    
    forkJoin([
        createObservable(1),
        createObservable(2),
    ])
    .pipe(
        mergeMap(i1 => {
           return createObservable(3).pipe(
               map(i => ({ i1, i }))
           );
        }) 
    ).subscribe((x) => {
        
        console.log('x.i1', x.i1);   // [1,2]
        console.log('x.i', x.i);     // 3
        
    });
</script>
```

### 從 array 幾乎平行跑 observable

```html
<script src="https://unpkg.com/rxjs@^7/dist/bundles/rxjs.umd.min.js"></script>
<script>
    const { from, of, range, interval, concat, forkJoin,  } = rxjs;
    const { map, mergeMap, filter, repeat, take, delay  } = rxjs.operators;
   
    function createObservable(i) {
        return of(i).pipe(delay(500));
    }
    
    const observables = [...Array(10).keys()].slice(1).map(i => createObservable(i));
    
    forkJoin(observables)
    .subscribe((x) => {
        console.log('x', x);     // [1,2,3,4,5,6,7,8,9]
    });
</script>
```