# asyns setup

component 使用 async setup 後，在呼叫該 component 時，就必須套用 Suspense

解法參考：

- [Why did I get blank (empty) content when I used async setup() in Vue.js 3?](https://stackoverflow.com/questions/64009348/why-did-i-get-blank-empty-content-when-i-used-async-setup-in-vue-js-3)
- [該解法的 Demo](https://stackblitz.com/edit/vue3-async-setup?file=src/App.vue)


#### 替代解法

如果不刻意在 setup() 中，必須執行 await 

可以放在 onMounted() 中執行 非同步 !

```js
onMounted( async () => {
    await new Promise((r) => setTimeout(r, 2000));
    console.log('delay complete');
});
```