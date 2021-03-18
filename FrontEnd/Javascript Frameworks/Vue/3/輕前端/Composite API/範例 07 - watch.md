# 範例 07 - watch

```html
<div id="app" class="text-center" style="display: none">
  <label>{{counter}}</label><br />
  <button @click="plusCounter">Plus Counter</button>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, ref, watch } = Vue;

  const RootComponent = {
    setup() {
      const counter = ref(0);

      const plusCounter = function () {
        console.log("plusCounter");

        // 加了之後，會反映至 Template 中
        counter.value++;
      };

      watch(counter, (newValue, oldValue) => {
        console.log("oldValue", oldValue);
        console.log("newValue", newValue);
      });

      return {
        counter,
        plusCounter,
      };
    },
  };

  const app = createApp(RootComponent);

  const vm = app.mount("#app");
  window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
  });
</script>

```