# 取用 setup 內的變數

```js
const vm = app.mount('#app');

const dtos = ref([
    {
        Details: [
            { Url: 'a', },
            { Url: 'b', },
        ],
    },
    {
        Details: [
            { Url: 'c', },
            { Url: 'd', },
            { Url: 'e', },
        ],
    },
]);

vm.dtos
  // 這樣可以排除 proxy 的封裝  
  .map((t) => t.Details)
  .reduce((a, b) => a.concat(b))
  .map((t) => t.Url);
```


