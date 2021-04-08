# v-model

## 傳入二個 v-model 至 child component

- 傳入 child component
  - props 一定要額外宣告
  - child component 內，必須要以 get / set 來處理 props
  - 更新的方式就是透過 emit 來處理

```csharp
<div id="app"
     class="text-center"
     style="display: none">
    <label>{{initial1}}</label>
    <label>{{initial2}}</label>
    <br>
    <custom-input v-model:value1="initial1"
                   v-model:value2="initial2">
    </custom-input>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, ref, onMounted, computed } = Vue;

  const app = createApp({
    setup(){
      const initial1 = ref(0);
      const initial2 = ref(1);
      return {
        initial1,
        initial2,
      }
    }
  });

  app.component("custom-input", {
    props: {
      value1: String,
      value2: String,
    },
    setup(props, { emit }){

      onMounted(() => {

      });

      const displayvalue1 = computed({
        get : () => {

          console.log('get');

          return props.value1;
        },
        set : (v) => {

          console.log('set:' + v);

          emit('update:value1', v);
        },
      });

      const displayvalue2 = computed({
        get : () => {

          console.log('get');

          return props.value2;
        },
        set : (v) => {

          console.log('set:' + v);

          emit('update:value2', v);
        },
      });

      return {
        displayvalue1,
        displayvalue2,
      }
    },
    template: `
<input type=text v-model="displayvalue1" />
<input type=text v-model="displayvalue2" />
`,
  });

  const vm = app.mount('#app');

  window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
  });

</script>
```
