# 假的 html tag

- 可以使用 `template` 來做為假的 html tag

```html
<div id="app" class="text-center" style="display: none">

  <ul>
    <template v-for="parentDto in sampleArray">
      <li v-for="dataDto in parentDto.data">
        {{dataDto}}
      </li>
    </template>
  </ul>

</div>

<script src="https://unpkg.com/vue@next"></script>

<script>
  const {
    createApp,
    reactive
  } = Vue;
  const RootComponent = {
    setup() {
      const sampleArray = reactive([{
        id: 1,
        data: [
          "1a",
          "1b",
          "1c",
        ]
      }, {
        id: 2,
        data: [
          "2a",
          "2b",
          "2c",
        ]
      }]);
      return {
        sampleArray,
      };
    },
  };
  const app = createApp(RootComponent);
  const vm = app.mount("#app");
  window.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("app").style.display = "block";
  });
</script>
```