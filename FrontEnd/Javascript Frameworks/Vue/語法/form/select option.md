# select option

```html
<div id="app">
    <select v-model="selected_item">
        <option selected disabled value="null">請選擇</option>
        <option v-for="item in items" v-bind:key="item.id">
            {{ item.name }}
        </option>
    </select>

    <!-- print result -->
    <div>{{ selected_item }}</div>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
    const {
        createApp,
        ref,
        reactive,
        onMounted,
        computed,
        watch,
        watchEffect,
    } = Vue;

    const app = createApp({
        setup() {
            const selected_item = ref(null);

            const items = ref([
                { id: 1, name: 'Apple' },
                { id: 2, name: 'Orange' },
                { id: 3, name: 'Mengo' },
                { id: 4, name: 'Cherry' },
            ]);

            return {
                selected_item,
                items,
            };
        },
    });
    app.mount('#app');
</script>
```
