# [props](https://vuejs.org/v2/guide/components-props.html)

-   可以給定 type 跟 required
-   要接外部 Property 的 Component
-   props - 宣告給外部 component 使用的 property

## [驗証](https://vuejs.org/v2/guide/components-props.html#Prop-Validation)

## [型別檢查](https://vuejs.org/v2/guide/components-props.html#Type-Checks)

## 範例

component 宣告方式

```js
Vue.component('product', {
    props: {
        message: {
            type: String,
            required: false,
            default : 'no data'
        },
    },
    template: `
    <div>
      <p>{{ message }}</p>
    </div>
  `,
    data() {
        return {};
    },
});
```

### view 的呼叫方式

-   如果要直接給定值

    ```html
    <product message="pp"></product>
    ```

-   如果要透過 binding property 來給定

    ```html
    <product :message="messageProperty"></product>
    ```

---

## 外部給定 Property 值

-   data - 要給 template binding 的 property

    ```html
    <template>
        <button @click="count++">You clicked me {{ count }} times.</button>
    </template>

    <script>
        export default {
            name: 'clickCountButton',
            props: ['initialCounter'],

            // 也可以寫成
            // props: { initialCounter: Boolean },

            data() {
                return {
                    count: this.initialCounter,
                };
            },
        };
    </script>
    ```

-   給定 Component Property 的方式

    > :Property="值"

    > v-bind:Property="值"

    ```html
    <template>
        <div>
            <clickCountButton :initialCounter="10" />
            <clickCountButton :initialCounter="20" />
            <!-- 這樣也可以 -->
            <!-- <clickCountButton v-bind:initialCounter="20" /> -->
        </div>
    </template>

    <script>
        import clickCountButton from '@/views/ClickCountButton.vue';

        export default {
            components: {
                clickCountButton,
            },
            data() {
                return {};
            },
        };
    </script>
    ```
