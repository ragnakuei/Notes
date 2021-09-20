# 範例 02 - DatePicker

- 因為 chrome 所提供的 input type=date 的 datepicker 只允許給定 yyyy-mm-dd，但會顯示 yyyy/mm/dd 格式
  為求給定資料的統一，透過 replaceAll() 來維持格式都以 yyyy/mm/dd 來呈現 !

```html
<div id="app" class="text-center" style="display: none">
  <label>{{initialDate}}</label><br>
  <datepicker v-model:modelValue="initialDate"></datepicker>
</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, ref, onMounted } = Vue;

  const app = createApp({
    setup(){
      const initialDate = ref('2020/12/31');
      return {
        initialDate,
      }
    }
  });
  
  app.component("datepicker", {
    props: {
      modelValue: String
    },
    computed: {
       innerModel: {
         get(){
           return this.modelValue.replaceAll('/','-');
         },
         set(v){
           this.$emit('update:modelValue', v.replaceAll('-','/'));
         }
       }
    },
    template: `<input type="date" v-model="innerModel" />`,   
  });
  
  const vm = app.mount('#app');
  window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
  });
</script>
```