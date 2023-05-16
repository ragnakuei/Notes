# 02 使用 [Local Registration](https://vuejs.org/guide/components/registration.html#local-registration)

```html
<script type="module">
    import {
        createApp,
        ref,
        onMounted,
        computed,
    } from 'https://unpkg.com/vue@3/dist/vue.esm-browser.js';

    import jquery_ui_date_picker from './jquery_ui_date_picker.js';

    const app = createApp({
        components: {
            jquery_ui_date_picker,     // 2. 可以直接改用這個方式註冊
        },
        setup() {
            const vmodel = ref({
                OrderDate: '',
            });
            const onValidateOrderDate = (value) => {
                // 大於今天才可以
                return new Date(value) > new Date();
            };

            function validateOrderDate(value, previousValue) {
                console.log('OrderDate previous value', previousValue);
                console.log('OrderDate current value', value);

                if (onValidateOrderDate(value)) {
                    vmodel.value.OrderDate = null;
                    alert('訂單日期不可大於今天');
                }
            }

            const submit_form = function () {
                console.log('submit');
            };
            return {
                vmodel,
                onValidateOrderDate,
                validateOrderDate,
                submit_form,
            };
        },
    })
        // .component('jquery_ui_date_picker', jquery_ui_date_picker)   1. 原本使用這個方式註冊的
        .mount('#app');
</script>
```
