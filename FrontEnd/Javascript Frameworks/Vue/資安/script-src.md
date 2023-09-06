# script-src

## 目前測試可行的設定

```html
<html lang="en">
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="utf-8" />
      <title>Test vue csp 01</title>
      <meta
        http-equiv="Content-Security-Policy"
        content="script-src 'unsafe-eval' 'nonce-123abc' https://unpkg.com/ ; "
      />
    </head>

    <body>

      <div id="app">
        <form autocomplete="off" v-on:submit.prevent="submit_form">
            <div>
                <label>訂單項目</label>

                <div v-for="item of display_items">
                    <label for="itemId">{{ item.name }}</label>
                    <input type="checkbox" id="itemId" v-model="item.checked"
                        v-on:change="changeChecked($event.target, item)" />
                </div>

            </div>
            <p>
                <button type="submit">送出</button>
            </p>
        </form>        
      </div>

      <script nonce="123abc" src="https://unpkg.com/vue@next"></script>
      <script nonce="123abc">
        const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;

        const app = createApp({
          setup() {
            const source_items = [
              { id: 1, name: "A" },
              { id: 2, name: "B" },
              { id: 3, name: "C" },
              { id: 4, name: "D" },
              { id: 5, name: "E" },
              { id: 6, name: "F" },
              { id: 7, name: "G" },
            ];

            const checkedIds = [1, 2, 3, 4, 5];
            const display_items = ref(clone(source_items));
            for (const item of display_items.value) {
              if (checkedIds.includes(item.id)) {
                item.checked = true;
              }
            }

            function clone(data) {
              return JSON.parse(JSON.stringify(data));
            }

            function changeChecked(target, item) {
              // console.log('target', target.checked);
              // console.log('item', item);

              if (target.checked) {
                if (!checkedIds.includes(item.id)) {
                  item.mode = "add";
                } else {
                  item.mode = "";
                }
              } else {
                if (checkedIds.includes(item.id)) {
                  item.mode = "remove";
                } else {
                  item.mode = "";
                }
              }
            }

            const submit_form = function () {
              console.log("display_items", display_items.value);
            };

            return {
              display_items,
              checkedIds,
              changeChecked,
              submit_form,
            };
          },
        });

        const vm = app.mount("#app");
      </script>
    </body>
  </html>
</html>

```