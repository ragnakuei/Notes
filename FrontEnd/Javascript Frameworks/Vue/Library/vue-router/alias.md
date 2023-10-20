# alias

讓多種 url 都可以使用相同的 route 設定 !

可以支援
- 不以 / 開頭，即為該 component 的 child route
- 以 / 開頭，即為 root route

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
                    <router-link to="/component3">Component3</router-link> |
                    <router-link to="/component4">Component4</router-link> |
                    <router-link to="/component5">Component5</router-link> |
                  </div>
                  <div>
                    <p>以下是 router-view</p>
                    <router-view></router-view>
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
                    {
                        path: '/', 
                        component: home
                    },
                    {
                        path: '/component1', 
                        component: component1,
                        alias: '/component3',
                    },
                    {
                        path: '/component2', 
                        name: 'component2',
                        // 以下寫法都可以，如果都是切換至同一個 component，url 不會有變化 !
                        // 單筆
                        // alias: '/component4',
                        // 多筆
                        alias: ['/component4', '/component5'],
                        component: component2
                    },
                ]
            });  
            
            createApp(app)
                .use(router)
                .mount('#app');
        </script>

    </body>
</html>
```