# 範例 05 - checkbox binding

```html
<form id="app">
  <div class="form-group form-check" 
       v-for="item in Items" 
       v-bind:key="item.id">
    <label class="form-check-label" 
           :for="item.name">
      {{item.name}}
    </label>
    <input type="checkbox" 
           v-model="user.fruitCollection" 
           :id="item.name" 
           :value="item.name">
  </div>

  <!-- print result -->
  <div class="form-group">
    {{user.fruitCollection}}
  </div>

</form>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const { createApp, reactive } = Vue;

  const app = createApp({
    data() {
      return {
        Items: [
          { name: 'Apple' },
          { name: 'Orange' },
          { name: 'Mengo' },
          { name: 'Cherry' }
        ],
        user: {
          // 如果未給定這個初始值，會變成，勾一個項目，就會變成全部連動
          fruitCollection: []
        }
      };
    },
    methods: {
      handleSubmit() {
        alert(JSON.stringify(this.user));
      }
    }
  });
  app.mount("#app");
  window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
  });
</script>
```

## 搭配 asp.net mvc 做 binding 的注意事項

```js

// 下拉選單資料從 ViewBag 來
const interests = @Html.Raw((ViewBag.Interests as CustomOptionItem<int>[]).ToJson());

// Model
// 如果 Model 沒有值，要記得先把 Interests 初始化成 empty array
const vm = @Html.Raw(Model?.ToJson() ?? "{ Interests : [] }");

const { createApp, reactive } = Vue;

const app = createApp({
    setup() {
        const interestsOptions = interests;

        const vModel = reactive({
            ViewModel : vm,
        });


        return {
            interestsOptions,
            vModel,
        };
    },
});
app.mount("#app");

window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
});
```
