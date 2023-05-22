# Publish Subscribe 01

```html
<input type="button" id="id" value="Publish 1" onclick="Publish(1)" />
<input type="button" id="id" value="Publish 2" onclick="Publish(2)" />

<script>
    function run(data) {
        console.log(data);
    }

    const subscriptions = [];
    function SubScribe(fn) {
        subscriptions.push(fn);
    }

    function Publish(data) {
        subscriptions.forEach((fn) => fn(data));
    }

    // subscribe
    SubScribe(run);
    SubScribe(run);
    SubScribe(run);
</script>
```
