# confirm 後才可以變更 radio button 的資料

```html
<div id="app">
    <div>
        <label for="yes">是
            <input type="radio"
                   v-model="vue_model.option_value"
                   name="option_value"
                   v-on:click="change_radio_to($event, 'yes')"
                   value="yes"
                   id="yes" />
        </label>
    </div>
    <div>    
        <label for="no">否
            <input type="radio"
                   v-model="vue_model.option_value"
                   name="option_value"
                   v-on:click="change_radio_to($event, 'no')"
                   value="no"
                   id="no" />
        </label>
    </div>
    <p>vue_model: {{ vue_model }}</p>
</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
  const { createApp, ref, reactive, onMounted, computed, watch, watchEffect } = Vue;
  
 const app = createApp({
        setup(){

          const vue_model = reactive({ option_value : '' });

          const submit_form = function() {
            console.log('submit');
          }
          
          function change_radio_to(e, target_value) {
              if(vue_model.option_value !== target_value 
                 && confirm('確認要變更 ?')) {
                  return true;
              }
              
              e.preventDefault();
          }

          return {
              vue_model,
              change_radio_to,
              submit_form,
          }
        }
      });

      const vm = app.mount('#app');
</script>
```