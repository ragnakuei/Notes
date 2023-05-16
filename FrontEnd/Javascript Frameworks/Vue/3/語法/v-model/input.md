# input

- 在無後端 ajax 同步資料的情況，透過 selectItem 來暫存選取的資料，當進行更新資料時，就從 editItem 將資料更新至 selectItem
- 在有後端 ajax 同步資料的情況，就不透過 selectItem 來暫存選取的資料，而是將選取的資料複製一份至 editItem，當資料更新後，就重新從後端取得資料，並回到初始狀態即可 !


```html
<div id="app">
    <form autocomplete="off"
          v-on:submit.prevent="submit_form">

        <ul>
            <li v-for="item in items"
                v-on:click="selectingItem(item)">
                {{ item.name }}
            </li>
        </ul>

        <child-component v-model="editItem.name"></child-component>

        <p>
            <button type="submit">更新</button>
        </p>
    </form>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
    const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;

    const app = createApp({
        setup() {

            const items = ref([
                { id: 1, name: 'A', isActive: false },
                { id: 2, name: 'B', isActive: false },
                { id: 3, name: 'C', isActive: true },
                { id: 4, name: 'D', isActive: false },
                { id: 5, name: 'E', isActive: true },
                { id: 6, name: 'F', isActive: false },
                { id: 7, name: 'G', isActive: false },
            ]);


            const editItem = ref({});
            function selectingItem(item) {
                console.log('click li', item);
                if (editItem.value.id === item.id) {
                    to_empty_mode();
                } else {
                    to_edit_mode(item);
                }

            }

            function to_empty_mode() {
                editItem.value = {};

            }
            function to_edit_mode(item) {
                editItem.value = { ...item };

            }

            const submit_form = function () {
                const selectItem = items.value.find(x => x.id === editItem.value.id);
                // 手動將值寫回去
                selectItem.name = editItem.value.name;
            }

            return {
                items,
                editItem,
                selectingItem,
                submit_form,
            }
        }
    });

    app.component('child-component', {
        props: {
            modelValue: String,
        },
        template: `
            <div>
                <h3>Child Component</h3>
                <input type="text" v-model="name"> 
            </div>
                `,
        emits: ['update:modelValue'],
        setup(props, { emit }) {


            const name = computed({
                get: () => props.modelValue,
                set: (v) => {
                    emit('update:modelValue', v)
                },
            });

            return {
                name,
            }
        }
    });

    const vm = app.mount('#app');
</script>
```