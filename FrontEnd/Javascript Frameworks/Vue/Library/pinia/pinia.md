# pinia

確保在不同 vue compnent 間共用同一個 store，甚至有 subscribe 的功能

[cdn 做法](https://github.com/vuejs/pinia/discussions/1051)

有版本相依性，要特別注意
```
1. vue 3.2.x 最多搭配至 pinia 2.0.x
1. vue 3.3.x 最多搭配至 pinia 2.1.x
```

```html
<html>
  <body>
    <style></style>

    <style>
      [v-cloak] {
        display: none;
      }
    </style>

    <div id="app">
      <button @click="plus">Plus</button>
      <p>First Instance: {{count}}</p>
    </div>

    <!-- <script src="https://unpkg.com/vue@next"></script> -->
    <script src="https://unpkg.com/vue@3.2.47/dist/vue.global.js"></script>

    <!-- VueDemi，使用 Pinia 必要的相依套件 -->
    <script src="https://unpkg.com/vue-demi"></script>
    <!-- <script src="https://unpkg.com/pinia"></script> -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.0.36/pinia.iife.js"></script>

    <script>
      const { createApp, ref, reactive, onMounted, computed } = Vue;
      const { createPinia, storeToRefs, defineStore, mapState, mapActions } = Pinia;

      const useCounterStore = defineStore("countStore", {
        state: () => ({
          count: 1, 
        }),
        actions: {
          increment() {
            this.count++;
          },
        },
      });

      const app = createApp({
        setup() {
          const countStore = useCounterStore();
          const { count } = storeToRefs(countStore);

          onMounted(() => {
            
          });

          function plus() {
            countStore.increment();
          }

          return {
            count,
            plus,
          };
        },
      });

      const pinia = createPinia();
      app.use(pinia);
      app.mount("#app");
    </script>
  </body>
</html>
```

上述的語法亦可簡化成不需要 storeToRefs 的寫法

```html
<html>
  <body>
    <style></style>

    <style>
      [v-cloak] {
        display: none;
      }
    </style>

    <div id="app">
      <button @click="plus">Plus</button>
      <p>First Instance: {{ countStore.count }}</p>
    </div>

    <!-- <script src="https://unpkg.com/vue@next"></script> -->
    <script src="https://unpkg.com/vue@3.2.47/dist/vue.global.js"></script>

    <!-- VueDemi，使用 Pinia 必要的相依套件 -->
    <script src="https://unpkg.com/vue-demi"></script>
    <!-- <script src="https://unpkg.com/pinia"></script> -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pinia/2.0.36/pinia.iife.js"></script>

    <script>
      const { createApp, ref, reactive, onMounted, computed } = Vue;
      const { createPinia, storeToRefs, defineStore, mapState, mapActions } = Pinia;

      const useCounterStore = defineStore("countStore", {
        state: () => ({
          count: 1, 
        }),
        actions: {
          increment() {
            this.count++;
          },
        },
      });

      const app = createApp({
        setup() {
          const countStore = useCounterStore();

          onMounted(() => {
            
          });

          function plus() {
            countStore.increment();
          }

          return {
            countStore,
            plus,
          };
        },
      });

      const pinia = createPinia();
      app.use(pinia);
      app.mount("#app");
    </script>
  </body>
</html>
```