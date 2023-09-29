# binding 與 rerender


### array

```js
setup() {

    const ary = ref([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    
    function removeItem() {
        // 不會觸發重新渲染
        // ary.pop();
        
        // 會觸發重新渲染
        ary.value = ary.value.slice(0, -1);
    }
    
    onMounted(() => {

    })
    return {
        ary,
        removeItem
    }
}

```


### object

```js
setup() {

    const obj = ref({ a: 1, b: 2, c: 3 });
    
    function removeItem() {
        // 不會觸發重新渲染
        // delete obj.value.c;
        
        // 會觸發重新渲染
        obj.value = { ...obj.value, c: undefined };
    }
    
    onMounted(() => {

    })
    return {
        obj,
        removeItem
    }
}

```

### object

vue 2 需要特別注意

但 vue 4 不需要