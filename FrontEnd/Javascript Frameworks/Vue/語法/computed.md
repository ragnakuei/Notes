# computed

## 範例

```js
const dom_value = computed({
    get: () => {
        return props.value;
    },
    set: (v) => {
        emit('update:value', v);
    },
});
```

```js
let propAField = ref('');
const propA = computed({
    get : () => {
        console.log('propA get',propAField.value);
        return propAField.value;
    },
    set : (v) => {
        propAField.value = v;
    }
});
```

## 注意事項

### 如果 computed property 未在 template 被呼叫，就等同於視為未宣告


