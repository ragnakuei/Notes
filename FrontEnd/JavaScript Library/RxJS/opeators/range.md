# range

```html
<script src="https://unpkg.com/rxjs@^7/dist/bundles/rxjs.umd.min.js"></script>
<script>
    const { range } = rxjs;
    const { map, filter, repeat } = rxjs.operators;

    range(1, 10)
        .pipe(repeat(2))
        .subscribe((x) => console.log(x));
</script>
```
