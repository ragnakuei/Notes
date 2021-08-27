# console 直接取用 vue app field 資料

```html
<style>
  [v-cloak] {
    display: none;
  }
</style>

<div id="app" class="text-center" v-cloak>
  <label>{{counter}}</label><br />
  <button v-on:click="plusCounter()">Plus Counter</button>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, ref } = Vue;

  const RootComponent = {
    setup() {
      const counter = ref(0);

      const plusCounter = function () {
        console.log("plusCounter");

        // 加了之後，會反映至 Template 中
        counter.value++;
      };

      return {
        counter,
        plusCounter,
      };
    },
  };

  const app = createApp(RootComponent);

  const vm = app.mount("#app");
  
  // 可以直接從 vm.counter 取出值 !
  window.setInterval(( () => console.log( vm.counter ) ), 1000);
  
</script>
```
