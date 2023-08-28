# radio button 取消 event

這只能用 click event 來取消，不能用 change event 來取消 !

```html
<html>
  <head></head>
  <body>
    <div id="app" v-cloak>
      <input v-model="radio_value" value="1" type="radio" v-on:click="change_radio_value" /> 1
      <input v-model="radio_value" value="0" type="radio" v-on:click="change_radio_value" /> 0

      <p>radio_value:{{radio_value}}</p>

      <hr />
    </div>

    <script src="https://unpkg.com/vue@next"></script>
    <script>
      const { createApp, ref, reactive, onMounted, computed } = Vue;

      const app = createApp({
        setup() {
          const radio_value = ref('');

          function change_radio_value(e) {
            const newValue = e.target.value;
            console.log(newValue);

            if(newValue === '0') {
              if(!confirm('cancel ?')) {
                e.preventDefault();
                return;
              }
            }

          }

          onMounted(() => {});
          return {
            radio_value,
            change_radio_value,
          };
        },
      });

      const vm = app.mount("#app");
    </script>
  </body>
</html>
```