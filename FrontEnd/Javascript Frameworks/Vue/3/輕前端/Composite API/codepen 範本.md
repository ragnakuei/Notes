# codepen 範本

```html
<style>
  [v-cloak] {
    display: none;
  }
</style>

<div id='app' v-cloak>

  <input v-model="value1" type="Date" />
  <input v-model="value2" type="Time" />
  
  <p>Value1:{{value1}}</p>
  <p>Value2:{{value2}}</p>
  
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
  const {
    createApp,
    ref,
    reactive,
    onMounted,
    computed
  } = Vue;
  
  const app = createApp({
    setup() {
      
      const value1 = ref('');
      const value2 = ref('');
      
      onMounted(() => {
        
      })
    return {
      value1,
      value2,
    }
  }
  });
  const vm = app.mount('#app');
</script>
```