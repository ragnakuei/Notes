# codepeng x-template 範例

```html
<div id="app">
    <form autocomplete="off" v-on:submit.prevent="submit_form">
        <p>
            <label for="OrderDate">訂單日期：</label>
            <input type="date" v-model="vue_model.OrderDate" id="OrderDate" />
        </p>
        <test></test>
        <div>{{ vue_model }}</div>
        <test></test>
        <p>
            <button type="submit">送出</button>
        </p>
    </form>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script type="text/x-template" id="test">
    <div>test</text>
</script>
<script>
    const test = {
        template: '#test',
        setup() {
            return {}
        }
    }
</script>

<script>
    const {
        createApp,
        ref,
        reactive,
        onMounted,
        computed,
        watch,
        watchEffect
    } = Vue;
    const app = createApp({
        setup() {
            const vue_model = reactive({ });
            const submit_form = function() {
                console.log('submit');
            }
            return {
                vue_model,
                submit_form,
            }
        }
    });
    app.component('test', test)
    const vm = app.mount('#app');
</script>
```