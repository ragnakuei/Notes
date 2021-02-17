# life cycle

## onMount

```html
<script>
    import { onMount } from 'svelte';

	onMount(() => {
	  // TODO
	});
</script>
```

## onDestroy

```html
<script>
    import { onDestroy } from 'svelte';
    let seconds = 0;
    const interval = setInterval(() => {seconds = seconds + 1;}, 1000)
    onDestroy(() => { clearInterval(interval); })
</script>
<style>
    h1 {
        color: purple;
    }
</style>
<h1>This is Home page</h1>
<p>It's been running for {seconds} seconds</p>
```