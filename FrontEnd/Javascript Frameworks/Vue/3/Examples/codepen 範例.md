# codepen 範例

```html
<div id="app">
    <form autocomplete="off"
          v-on:submit.prevent="submit_form">
        <p>
            <label for="OrderDate">訂單日期：</label>
            <input type="date"
                   v-model="vmodel.OrderDate"
                   id="OrderDate" />
        </p>
        <div>
            <label>訂單項目</label>
            <p v-for="(item, index) in vmodel.Items"
               v-bind:key="index">
                <input type="text"
                       v-model="vmodel.Items[index]" />
            </p>
            <p>{{ vmodel }}</p>
        </div>
        <p>
            <button type="submit">送出</button>
        </p>
    </form>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
  const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;
  
 const app = createApp({
        setup(){

          const vmodel = reactive({ OrderDate : '', Items : [null, null, null] });

          const submit_form = function() {
            console.log('submit');
          }

          return {
              vmodel,
              submit_form,
          }
        }
      });

      const vm = app.mount('#app');
</script>
```