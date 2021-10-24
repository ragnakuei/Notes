# interval

```html
<script src="https://unpkg.com/rxjs@^7/dist/bundles/rxjs.umd.min.js"></script>
<script>
    const { from, of, range, interval, concat } = rxjs;
    const { map, filter, repeat, take  } = rxjs.operators;
   
    concat(
        interval(100).pipe(
            take(10)
        ),
        interval(500).pipe(
            take(3),
            map(i => i + 10)
        )
    ).subscribe((x) => console.log(x));
</script>
```
