# watch


### watch 運算式

有一組資料，包含了 a、b、c，以及一個計算結果欄位 other：a + b - c
其中 a、b、other 為可編輯，而 c 為固定值，且不可編輯。

需求： a、b、c 任一變動，都要重新計算 other

```html
<html>
  <body>
    <div id="app">
      <div>
        <div>
          <span >a: <input type="number" v-model="obj.a" /></span>&nbsp;&nbsp;
          <span >b: <input type="number" v-model="obj.b" /></span> &nbsp;&nbsp;
          <span>a+b: {{ obj.a + obj.b }} </span>
        </div>
        <div>
          <span >a+b-c: <input type="number" v-model="obj.other" /> </span>
          <span>c: {{ obj.c }} </span>
        </div>
      </div>
    </div>

    <script src="https://unpkg.com/vue@next"></script>
    <script>
      const { createApp, ref, reactive, watch } = Vue;

      const app = createApp({
        setup() {
          const obj = ref({
            a: 3,
            b: 4,
            c: 5,
            other: 2
          });

            watch(
                () => obj.value.a + obj.value.b - obj.value.other,
                (newValue, oldValue) => {
                    obj.value.c = newValue;
                }
            );

          return {
            obj,
          };
        },
      });

      const vm = app.mount("#app");
    </script>
  </body>
</html>
```