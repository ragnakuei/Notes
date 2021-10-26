# computed

#### 範例1

```js
const dto1 = ref('');
const dto2 = computed({
    get : () => dto1,
    set : (v) => {
    dto1.value = v;  
    },
});
```

#### 範例2

- 如果有 back field 時，back field 也要是 reactive 的
- 因為 back field 是 reactive ，所以在 computed get from back field 時，要記得給定 .value !

```html
<script src="https://unpkg.com/vue@next"></script>

<div id="app">
    <form autocomplete="off">
        <p>
            <input v-model="dto1" />
        </p>
        <p>
            <input v-model="dto2.value" />
        </p>
    </form>
</div>


<script>
  const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;
  
 const app = createApp({
        setup(){

          const dto1 = ref('');
          const dto2 = computed({
              // 要記得給定 .value
              get : () => dto1.value,
              set : (v) => {
                dto1.value = v;  
              },
          });

          return {
              dto1,
              dto2,
          }
        }
      });

      const vm = app.mount('#app');
</script>
```

## 注意事項

### 如果 computed property 未在 template 被呼叫，就等同於視為未宣告


