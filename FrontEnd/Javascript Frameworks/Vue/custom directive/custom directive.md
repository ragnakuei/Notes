# custom directive

[Creating Your First Vue Custom Directive - with Vue 3 Updates](https://learnvue.co/2020/01/creating-your-first-vuejs-custom-directive/)
 [我的第一個 npm 套件：把 vue component 打包到 npm 吧](https://medium.com/@debbyji/%E6%88%91%E7%9A%84%E7%AC%AC%E4%B8%80%E5%80%8B-npm-%E5%A5%97%E4%BB%B6-%E6%8A%8A-vue-component-%E6%89%93%E5%8C%85%E5%88%B0-npm-%E5%90%A7-e5f9a6901c5c)


#### 出現 [Vue warn]: Property "xxx" was accessed during render but is not defined on instance. 錯誤訊息

原因：下面 required 未給定 值，而只給 欄位，就會這樣 !

```html
<input id="name"
        type="text"
        v-model="model.name"
        v-validate="{ name: 'name', rule : { required, minLength: 1, maxLength: 3 } }"
/>
```

解決方式：required 給定值 true 就正常了 !


```html
<input id="name"
        type="text"
        v-model="model.name"
        v-validate="{ name: 'name', rule : { required: true, minLength: 1, maxLength: 3 } }"
/>
```