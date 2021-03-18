# Event Bubble

## 預防 Event Bubble

大多數情況，可以用:

```js
e.preventDefault();
```

當上述情況無效時，可以試試用這個:

```js
e.stopImmediatePropagation();
```
