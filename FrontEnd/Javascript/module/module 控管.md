# module 控管

- 第二個 module 因為有加上 ?1，所以會被當成不同的 module
- 如果要使用相同的 module，就不能加上 ?1，就可以做到 cache 的效果

```html
<script type="module">
    import { counter } from '/js/module/calculator.js';

    document.getElementById('btn').addEventListener('click', function () {
        const result = counter();
        document.getElementById('result').innerHTML = result;
    });
</script>

<script type="module">
    import { counter } from '/js/module/calculator.js?1';

    document.getElementById('btn1').addEventListener('click', function () {
        const result = counter();
        document.getElementById('result').innerHTML = result;
    });
</script>
```
