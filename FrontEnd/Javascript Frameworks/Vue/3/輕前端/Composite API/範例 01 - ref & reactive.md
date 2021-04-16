# 範例 01 - ref & reactive

- ref() 內給定的是 primitive type
  - 必須以 變數.value 來存取
  - Array 要用 ref !
- reactive() 內給定的是 object
  - 不用以 變數.value 來存取

## 不會更新 Count 的範例

```html
<div id="app" class="text-center" style="display: none">
  <label>{{counter}}</label><br />
  <button @click="plusCounter">Plus Counter</button>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const RootComponent = {
    setup() {
      let counter = 0;

      const plusCounter = function () {
        console.log("plusCounter");

        // 加了之後，不會反映至 Template 中
        counter++;
      };

      return {
        counter,
        plusCounter,
      };
    },
  };

  const app = Vue.createApp(RootComponent);

  const vm = app.mount("#app");
  document.getElementById("app").style.display = "block";
</script>
```

## ref

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
</script>
```


## reactive

```html
<div id="app" class="text-center" style="display: none">
  <label>{{counterObj.counter}}</label><br />
  <button @click="plusCounter">Plus Counter</button>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, reactive } = Vue;

  const RootComponent = {
    setup() {
      const counterObj = reactive({
        counter: 0,
      });

      const plusCounter = function () {
        console.log("plusCounter");

        // 加了之後，會反映至 Template 中
        counterObj.counter++;
      };

      return {
        counterObj,
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