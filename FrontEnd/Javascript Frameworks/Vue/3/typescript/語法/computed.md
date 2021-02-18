# computed

## get

```ts
const currentCounter = computed(() => c.counter.value);
```

## get / set

```ts
const selectDate = computed({
        get : () => props.modelValue,
        set : (v) => emit('update:modelValue', v),
    });
```
