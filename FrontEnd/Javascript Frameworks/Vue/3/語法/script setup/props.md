# props

### 範例

-   non script-setup

    ```js
    export default {
        props: {
            item: {
                id: Number,
                name: String,
                isActive: Boolean,
            },
        },
        setup(props) {
            console.log(props.item);
        },
    };
    ```

-   script-setup

    ```js
    <script setup>
    import { ref } from 'vue'

    const props = defineProps({
        item: {
            id: Number,
            name: String,
            isActive: Boolean,
        },
    })
    </script>
    ```
