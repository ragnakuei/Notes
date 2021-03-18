# 範例 03 - 加上 component

- 引用 axios cdn
- 直接以 axois 方式來使用

## 放在 asp.net core mvc 中

```html
@{
}

<div id="app">
    <component-a></component-a>
    <component-b></component-b>
</div>

@section Scripts
{
    <script src="https://unpkg.com/vue@3.0.2/dist/vue.global.prod.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <script>
        const RootComponent = {

         };
        const app = Vue.createApp(RootComponent);

        @* component 的給定，要在 Vue.mount() 之前 *@
        app.component('component-a', {
            template: `
                <p>component-a</p>
            `
        });
        app.component('component-b', {
            template: `
                <span>Message: {{ count }}</span>
                <div>
                    {{ info }}
                </div>
            `,
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
        });

        const vm = app.mount('#app');
    </script>

}
```