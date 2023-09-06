# jquery ui sorttable

### 範例：需求 額外增加目前排序欄位

- 增加目前排序欄位名稱為 No
  - 此欄位由 vue 負責


```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1"
    />
    <title>jQuery UI Sortable - Drop placeholder</title>
  </head>
  <body>
    <div id="app">
      <table>
        <thead>
          <tr>
            <th>Id</th>
            <th>Name</th>
            <th>No</th>
          </tr>
        </thead>
        <tbody id="sortable">
          <template
            v-for="(item, item_index) in items"
            v-bind:key="item.id"
          >
            <tr v-bind:id="item.id">
              <td>{{ item.id }}</td>
              <td>{{ item.name }}</td>
              <td>{{ item_index + 1 }}</td>
            </tr>
          </template>
        </tbody>
      </table>

      <div>items: {{ items }}</div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://unpkg.com/vue@next"></script>
    <script>
      const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;

      const app = createApp({
        setup() {
          const items = ref([
            { id: 1, name: "A" },
            { id: 2, name: "B" },
            { id: 3, name: "C" },
            { id: 4, name: "D" },
            { id: 5, name: "E" },
            { id: 6, name: "F" },
            { id: 7, name: "G" },
          ]);

          const dom_id = ref("sortable");

          let sorttable_instance = ref(null);

          onMounted(() => {
            sorttable_instance.value = $("#" + dom_id.value);

            sorttable_instance.value
              .sortable({
                change: function (event, ui) {
                  // console.log("change");
                },
                update: function (event, ui) {
                  // console.log("update");

                  items.value = sorttable_instance.value.sortable("toArray").map((id) => {
                    return items.value.find((item) => item.id == id);
                  });

                  sorttable_instance.value.sortable("refreshPositions");
                },
              })
              .disableSelection();
          });

          const submit_form = function () {};

          return {
            items,
            submit_form,
          };
        },
      });

      const vm = app.mount("#app");
    </script>
  </body>
</html>
```
