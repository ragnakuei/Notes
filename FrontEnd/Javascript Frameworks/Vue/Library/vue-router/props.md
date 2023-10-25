# props

[Passing Props to Route Components](https://router.vuejs.org/guide/essentials/passing-props.html)

## 給定固定的 props

```js
{
    // 這邊不需要指定 :id
    path: '/component1', 
    name: 'component1',
    component: component1,

    // 當此處設定為物件時，則會將物件內的值轉為 props
    props: { id : 5 }
},
```

## 給定動態的 props

```js
{
    // 這邊不需要指定 :id
    path: '/component1', 
    name: 'component1',
    component: component1,

    // 當此處設定為物件時，則會將物件內的值轉為 props
    props: route => {
        const id = Number(route.query.id);
        return { id };
    }

},
```

## 讓 router param 可以轉為 props

簡短範例：

```js
{
    path: '/component1/:id', 
    name: 'component1',
    component: component1,

    // 當此處設定為 true 時，則會將 router param 轉為 props
    props: true,
},
```

提昇 component 的重用性 !

當指定的 route 有設定 props: true 時，則會將 router param 轉為 props

完整範例：

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
                    <router-link v-bind:to="{ name: 'component1', params: { id : 3 }  }">Component1</router-link> |
                  </div>
                  <div>
                    <p>以下是 router-view</p>
                    <router-view></router-view>
                  </div>
                `,
                setup() {
                    return {
                    }
                }
            };

            const home = {
                template: `<div>home</div>`,
                setup(props, {emit}) { return {} }
            };
            
            const component1 = {
                template: `<div>component1 id: {{ id }}</div>`,
                props: {
                    id : {
                        type: String,
                        required: true,
                    },
                },
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
                        path: '/component1/:id', 
                        name: 'component1',
                        component: component1,

                        // 當此處設定為 true 時，則會將 router param 轉為 props
                        props: true,
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