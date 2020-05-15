# custom event

在 component 定義外部可以使用的 event

## 範例

- parent

  - onButtonClick 是子類提供的 custom event

    ```html
    <template>
        <div>
            <checkedButton v-bind:id="1"
                           v-bind:initialChecked="false"
                           v-on:onButtonClick="checkedButtonClick" />

            <checkedButton v-bind:id="2"
                           v-bind:initialChecked="true"
                           v-on:onButtonClick="checkedButtonClick" />
        </div>
    </template>

    <script>
        import checkedButton from "@/views/CheckedButton.vue"

        export default {
            components : {
                checkedButton
            },
            data() {
                return {
                }
            },
            methods : {
                checkedButtonClick : function(target) {
                    console.log(target);
                }
            }
        } 
    </script>
    ```

- child component

  - 透過 `this.$emit('custom event name', value)`  來呼叫與外部溝通的 Event
  - onButtonClick 是子類提供的 custom event

    ```html
    <template>
        <button @click="onClick">Checked : {{ isChecked }}</button>
    </template>

    <script>
        export default {
            name: "checkedButton",
            props: {
                initialChecked : Boolean,
                id: Number,
            },
            data() {
                return {
                    isChecked : this.initialChecked
                }
            },
            methods : {
                onClick : function(t) {
                    // t : MouseEvent
                    // console.log(t);

                    this.isChecked = !this.isChecked;

                    this.$emit("onButtonClick", {
                        id: this.id,
                        isChecked: this.isChecked,
                    });
                }
            }
        }
    </script>
    ```
