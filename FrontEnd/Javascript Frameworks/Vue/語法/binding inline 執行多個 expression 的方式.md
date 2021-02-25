# binding inline 執行多個 expression 的方式

## 範例

如下圖 `v-on:click="value.isChecked = !value.isChecked, ShowButtons()"` 透過 , 分隔 expression 就可以了 !

```js
<template>
    <div>
        <input v-for="value in buttons"
               v-on:click="value.isChecked = !value.isChecked, ShowButtons()"
               v-bind:value="value.isChecked"
        />

    </div>
</template>

<script>
    import checkedButton from "@/views/CheckedButton.vue"

    export default {
        components: {
            checkedButton
        },
        props: [],
        data() {
            return {
                buttons: [
                    {id: 1, isChecked: false},
                    {id: 2, isChecked: true},
                    {id: 3, isChecked: false},
                ],
                group2: [],
            }
        },
        methods: {
            ShowButtons() {
                console.table(this.buttons);
            }
        }
    }
</script>
```