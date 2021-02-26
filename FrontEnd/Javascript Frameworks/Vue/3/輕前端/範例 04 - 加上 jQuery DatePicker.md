# 範例 04 - 加上 jQuery DatePicker

```html
<div id="app" class="text-center" style="display: none">
  <label>{{initialDate}}</label><br>
  <jquery-ui-datepicker v-model="initialDate"></jquery-ui-datepicker>
</div>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="https://unpkg.com/vue@3.0.5/dist/vue.global.js"></script>

<script>
  const RootComponent = {
    data() {
      return {
        initialDate: "2020-12-31",
      };
    },
  };
  const app = Vue.createApp(RootComponent);
  app.component("jquery-ui-datepicker", {
    data() {
      return {
        datePickerDom: null,
      }
    },
    mounted() {
      this.datePickerDom = $("#datepicker");
      this.datePickerDom.datepicker("option", "dateFormat", "yy/mm/dd");
    },
    props: {
      modelValue: String
    },
    computed: {
      selectDate: {
        get() {
          return this.modelValue;
        },
        set(v) {
          this.$emit('update:modelValue', v);
        }
      }
    },
    template: `<input type="date" id="datepicker" v-model="selectDate" />`,
  });
  const vm = app.mount('#app');
  document.getElementById("app").style.display = "block";
</script>
```