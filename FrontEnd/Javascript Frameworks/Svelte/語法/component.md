# component

## props

- props 
  - 以 export let variable 的方式宣告 !
  - 可給定初始值

App.svelte

```html
<script>
	import Nested from "./Nested.svelte";

	export let name;

	const answer = 3;
</script>

<main>
	<h1>Hello {name}!</h1>
	<p>Visit the <a href="https://svelte.dev/tutorial">Svelte tutorial</a> to learn how to build Svelte apps.</p>
</main>
<!-- 可直接放值 -->
<Nested answer={2} />

<!-- 也可直接放變數 -->
<Nested answer={answer} />
```

Nested.svelte

```html
<script>
    // props
    export let answer;
    
    // 給定 props 初始值，如果 parent component 未給定 props 的值，就會以初始值顯示
	// export let answer = 0;
</script>

<p>The answer is {answer}</p>
```

## Spread props

- 傳入 object 至 child component 中
  - object.property 與 child component 的 props 的 name 對應
  - 省去逐個 property 對應

App.svelte

```html
<script>
	import Nested from "./Nested.svelte";

	export let name;

	const dto = {
		a: 1,
		b: 2,
		c: 3
	};
</script>

<main>
	<h1>Hello {name}!</h1>
</main>
<Nested {...dto} />
```

Nested.svelte

```html
<script>
	export let a,b;
	export let c;
</script>

<p>A:{a}</p>
<p>B:{b}</p>
<p>C:{c}</p>
```

