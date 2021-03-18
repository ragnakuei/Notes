# selector samples


## id 以 xxx 開頭

```js
$('[id^="xxx"]').each((index, dom) =>{
    console.log('domId',dom.id);
});
```

## id 以 yyy 結尾

```js
$('[id$="yyy"]').each((index, dom) =>{
    console.log('domId',dom.id);
});
```

## id 以 xxx 開頭 AND id 以 yyy 結尾

```js
$('[id^="xxx"][id$="yyy"]').each((index, dom) =>{
    console.log('domId',dom.id);
});
```
