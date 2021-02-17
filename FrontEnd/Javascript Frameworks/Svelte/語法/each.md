# [each](https://svelte.dev/docs#each)

- #each [] as item,index

## 範例一

```html
<script>
    let cats = [
        {id: 'J---aiyznGQ', name: 'Keyboard Cat'},
        {id: 'z_AbfPXTKms', name: 'Maru'},
        {id: 'OUtn3pvWmpg', name: 'Henri The Existential Cat'}
    ];
</script>

<h1>The Famous Cats of YouTube</h1>

<ul>
    {#each cats as {id, name}, i}
        <li>
            <a target="_blank"
               href="https://www.youtube.com/watch?v={id}">
                {i + 1}: {name}
            </a>
        </li>
    {/each}
</ul>

```

## 範例二 - 在 child component 複製 props 至變數的注意事項

App.svelte

```html
<script>
    import Nested from "./Nested.svelte";

    let cats = [
        {id: 'A', name: 'NameA'},
        {id: 'B', name: 'NameB'},
        {id: 'C', name: 'NameC'},
        {id: 'D', name: 'NameD'},
        {id: 'E', name: 'NameE'},
    ];

    function removeFirstCat() {
        cats = cats.splice(1);
    }
</script>

<h1>Cats List</h1>
<button on:click={removeFirstCat}>Remove First Cat</button>
<ul>
    <!-- 使用這個語法，會造成複製 props 後的資料順序與 props 不同 -->
    <!-- {#each cats as cat, i} -->

    <!-- 建議的語法，讓 child component 能夠辨識傳入物件的 identity -->
    {#each cats as cat, i (cat.id)}
        <Nested id={cat.id}
                name={cat.name} />
    {/each}
</ul>

```

Nested.svelte

```html
<script>
    export let id;
    export let name;

    const initialName = name;
</script>

<li>
    {id} - {initialName} - {name}
</li>

```