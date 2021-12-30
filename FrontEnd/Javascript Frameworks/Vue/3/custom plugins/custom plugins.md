# custom plugins

#### js 版

FormPlugin.js

```js
export default {
    // app：與 main.js createApp(App) 的 return 變數相同
    install: (app, options) => {

        // 可以加上 global 的 component
        // app.component("my-header", MyHeader);

        // 可以加上 global 的 directive
        // app.directive("font-size", (el, binding, vnode) => {
         // ...
        // });

        // 可以將 app.Use( xxx , options) 的 options 傳入至引數的 options
        // console.log(options.option1);

        // 可以使用 mixin
        // app.mixin({});

        // 可以使用 provide
        // component 要記得 inject => const validateForm = inject('validateForm');
        // app.provide("validateForm", function(propertyName) {
        //     console.log(propertyName);
        // });

        // 指定 globalProperties
        // app.config.globalProperties.validateForm = function( propertyName ) {
        //     console.log( propertyName );
        // };
    },
}
```

main.js

```js
import { createApp } from 'vue'
import App from './App.vue'
import FormPlugin from "./Plugins/FormPlugin";

createApp(App)
    .use(FormPlugin, { option1 : 'A' })
    .mount('#app')
```
