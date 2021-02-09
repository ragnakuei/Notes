# on-input sample

```html
<div id="app" class="text-center" style="display: none">
  <label>{{test}}</label><br>
  <custom-input :title="test" v-on:on-input="datePickerOnInput"></custom-input>
  <button-counter />
</div>

<script src="https://unpkg.com/vue@3.0.5/dist/vue.global.js"></script>

<script>
  const RootComponent = {
    data() {
      return {
        test: "ABC",
      };
    },
    methods: {
      datePickerOnInput: function(obj) {
        this.test = obj.value;
      }
    }
  };
  const app = Vue.createApp(RootComponent);
  app.component("custom-input", {
    props: {
      title: String
    },
    data() {
      return {
        currentTitle: this.title
      }
    },
    template: `<input type="text" v-model="currentTitle" @input="onInput">`,
    methods: {
      onInput: function(t) {
        // 因為外部註冊事件時，要用 on-input ，所以此處用 on-input 會比用 onInput 來的好 !
        this.$emit("on-input", {
          value: this.currentTitle,
        });
      }
    }
  });
  const vm = app.mount('#app');
  document.getElementById("app").style.display = "block";
</script>
```