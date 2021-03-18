# reactive

三種型式

## 型式一 : expression

```js
$: console.log(`the count is ${count}`);
```

## 型式二 : block

```js
$: {
	console.log(`the count is ${count}`);
	alert(`I SAID THE COUNT IS ${count}`);
}
```

## 型式三 : if block

```js
$: if (count >= 10) {
	alert(`count is dangerously high!`);
	count = 9;
}
```