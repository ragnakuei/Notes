# 04 使用 [defineAsyncComponent](https://vuejs.org/guide/components/async.html#async-components)

按下 Toggle 按鈕，可以看到 jquery_ui_date_picker 的載入時機

-   template

    ```html
    <div id="app">
        <button type="button" v-on:click="show = !show">Toggle</button>

        <p v-if="show">
            <label for="OrderDate">訂單日期：</label>
            <jquery_ui_date_picker
                id="OrderDate"
                v-model="vmodel.OrderDate"
                v-on:select="validateOrderDate"
            ></jquery_ui_date_picker>
            {{ vmodel.OrderDate }}
        </p>
        <div></div>
    </div>
    ```

-   script

    ```js
    import {
        createApp,
        ref,
        onMounted,
        computed,
        defineAsyncComponent,
    } from 'https://unpkg.com/vue@3/dist/vue.esm-browser.js';

    const jquery_ui_date_picker = defineAsyncComponent(() =>
        // 2. 這邊 import 預設會抓 export default 的值
        import('/jQuery UI/jquery_ui_date_picker.js'),
    );

    const app = createApp({
        components: {
            jquery_ui_date_picker,

            // 3. 也可以這樣寫，語法會較為簡潔
            // jquery_ui_date_picker: defineAsyncComponent(() => import('/jQuery UI/jquery_ui_date_picker.js')),
        },
        setup() {
            // ....

            const show = ref(false);

            return {
                show,
                // ...
            };
        },
    }).mount('#app');
    ```

-   jquery_ui_date_picker.js

    ```js
    import {
        ref,
        onMounted,
        computed,
    } from 'https://unpkg.com/vue@3/dist/vue.esm-browser.js';
    import { debounce } from '/jQuery UI/debounce.js';

    // 1. 這邊一定要用 export default
    export default {
        template: `
    <input ref="dom"
    v-bind:id="id" 
    v-model="selectDate"
    v-on:focus="focus"
    v-on:blur="blur" />
        `,
        props: {
            id: String,
            format: String,
            modelValue: String,
        },
        emits: ['update:modelValue', 'select'],
        setup(props, { emit }) {
            // ...

            return {
                // ...
            };
        },
    };
    ```
