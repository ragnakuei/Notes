# prevent XSS attack example

- 透過 額外套件：he 做 content encode
- 透過 v-html 做 content encode

```html
<div id="app">
  <input type="text" v-model="name" />
  <p>{{ name }}</p>
  <p v-html="model.name"></p>
</div>


<script src="https://unpkg.com/vue@next"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/he/1.2.0/he.min.js"></script>
<script>
  const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;

  const app = createApp({
    setup(){

      const model = ref({"name":"&lt;script&gt;alert(&#39;名稱&#39;)&lt;/script&gt;"});

      const name = computed({
        get: () => {
          return he.decode( model.value.name );
        },
        set: v => {
          model.value.name = he.encode(v);
        },
      });
      
      return {
        model,
        name,
      }
    }
  });

const vm = app.mount('#app');
</script>
```