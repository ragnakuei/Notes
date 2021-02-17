# logic

## if

```html
<script>
  let toggleFlag = false;

  function toggle() {
    toggleFlag = !toggleFlag;
  }
</script>

<main>
  {#if toggleFlag}
    <p>show</p>
  {/if}

  {#if toggleFlag === false}
    <p>hidden</p>
  {/if}

  <button on:click={toggle}> Toggle </button>
</main>
```

## if else

```html
<script>
  let x = 0;

  function plus() {
    x++;
  }
</script>

{#if x > 5}
  <p>{x} is greater than 5</p>
{:else if 3 > x}
  <p>{x} is less than 3</p>
{:else}
  <p>{x} is between 3 and 5</p>
{/if}

<button on:click={plus}> Plus </button>
```


