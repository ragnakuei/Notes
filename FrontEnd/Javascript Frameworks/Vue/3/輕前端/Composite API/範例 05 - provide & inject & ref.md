# 範例 05 - provide & inject & ref.md

- provide
  - 資料提供者
  - 從 parent component 給定
- inject
  - 資料接收者
  - 從 child component 取出，可跨層 !
- 傳遞的資料，要用 ref / reactive 包裝 !

```html
<div id="app" class="text-center" style="display: none">
  <label>App:{{counter}}</label><br />
  <button @@click="plusCounter">Plus Counter</button><br />
  <child-counter></child-counter>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, ref, provide, inject } = Vue;

  const RootComponent = {
    setup() {
      const counter = ref(0);

      const plusCounter = function () {
        console.log("plusCounter");
        counter.value++;
      };

      // 讓 child component 可以用 inject counter 來取得 counter 的值
      provide("counter", counter);

      return {
        counter,
        plusCounter,
      };
    },
  };

  const app = createApp(RootComponent);

  app.component("child-counter", {
    setup() {
      // inject counter 來取得 counter 的值
      const counter = inject("counter");

      return {
        counter,
      };
    },
    template: `<label>Child:{{counter}}</label>`,
  });

  const vm = app.mount("#app");
  document.getElementById("app").style.display = "block";
</script>
```
