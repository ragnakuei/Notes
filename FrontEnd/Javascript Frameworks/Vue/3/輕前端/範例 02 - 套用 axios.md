# 範例 02 - 套用 axios

- 引用 axios cdn
- 直接以 axois 方式來使用

## 放在 asp.net core mvc 中

```html
@{
}

<div id="app"
    style="display: none">
    <span>Message: {{ count }}</span>
    <div>
        {{ info }}
    </div>
    <component-a></component-a>
</div>

@section Scripts
{
    <script src="https://unpkg.com/vue@3.0.2/dist/vue.global.prod.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <script>
        const RootComponent = {
              data() {
                return {
                    count: 4,
                    info: null,
                }
              },
              created() {
                console.log('count is: ' + this.count) // => "count is: 1"
              },
              mounted () {
                axios.get('https://api.coindesk.com/v1/bpi/currentprice.json')
                     .then(response => (this.info = response))
              }
         };
        const app = Vue.createApp(RootComponent);
        const vm = app.mount('#app');

        document.getElementById("app").style.display = "block";
    </script>

}

```