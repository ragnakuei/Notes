# cdn 版範例 Named Views

[Named Views](https://router.vuejs.org/guide/essentials/named-views.html)

可以用在，同一個 url 要同時顯示多個 router-view 的情境

```html
<!DOCTYPE html>
<html lang="en">
    <head>
        <!-- named route -->
        <meta charset="UTF-8">
        <title>Vue Example</title>
        <style>
            [v-cloak] {
                display: none;
            }
        </style>
    </head>
    <body>


        <div id='app' v-cloak></div>

        <script src="https://unpkg.com/vue@3"></script>
        <script src="https://unpkg.com/vue-router@4"></script>
        <script>
            const {createApp, ref, reactive, onMounted, computed} = Vue;
            const {createRouter, createWebHashHistory} = VueRouter;

            const app = {
                template: `
                  <h1>Router</h1>
                  <div>
                    <p>nav</p>
                    <router-link to="/">Home</router-link> |
                    <router-link to="/component1">Component1</router-link> |
                    <router-link to="/component2">Component2</router-link> |
                    <router-link to="/components">Components</router-link>
                  </div>
                  <div>
                    <p>以下是 router-view</p>
                    <router-view name="default"></router-view>
                    <router-view name="route-view-2"></router-view>
                  </div>
                `,
                setup() {

                    const counter = ref(2);

                    return {
                        counter,
                    }
                }
            };

            const home = {
                template: `<div>home</div>`,
                setup(props, {emit}) { return {} }
            };
            
            const component1 = {
                template: `<div>component1</div>`,
                setup(props, {emit}) { return {} }
            };

            const component2 = {
                template: `<div>component2</div>`,
                setup(props, {emit}) { return {} }
            };

            const router = createRouter({
                history: createWebHashHistory(),
                routes: [
                    {path: '/', component: home},
                    {path: '/component1', component: component1},
                    {path: '/component2', component: component2},
                    {
                        path: '/components', components: {
                            // 預設的 router-view name 是 default
                            default: component1,
                            // 自訂的 router-view name 是 route-view-2
                            'route-view-2': component2,
                        }
                    },
                ]
            })
                createApp(app)
                .use(router)
                .mount('#app');
        </script>

    </body>
</html>

```