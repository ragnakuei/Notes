# v-for + tr


```js
<div id='app' >

    <table>
        <thead>
            <tr>
                <th>id</th>
                <th>name</th>
                <th>isActive</th>
            </tr>
        </thead>
        <tbody>
            <template v-for="item in items">
                <tr>
                    <child-component v-bind:item="item" />
                </tr>
            </template>

            <!-- 下面這種語法會出錯 ! -->
            <!-- <tr v-for="item in items">
                <child-component v-bind:item="item" ></child-component>
            </tr> -->

        </tbody>
    </table>

    <p>items:{{items}}</p>

</div>

<script src="https://unpkg.com/vue@next"></script>
<script>
    const {
        createApp,
        ref,
        reactive
    } = Vue;

    const app = createApp({
        setup() {

            const items = reactive(
                [{
                    id: 1,
                    name: "A",
                    isActive: true,
                }, {
                    id: 2,
                    name: "B",
                    isActive: true,
                }, {
                    id: 3,
                    name: "C",
                    isActive: true,
                }, {
                    id: 4,
                    name: "D",
                    isActive: false,
                }, {
                    id: 5,
                    name: "E",
                    isActive: true,
                }]
            );

            return {
                items,
            }
        }
    });

    app.component('child-component', {
        props: {
            item: {
                id: Number,
                name: String,
                isActive: Boolean,
            },
        },
        template: `
                     <td>{{ item.id }}</td>
                     <td>{{ item.name }}</td>
                     <td>{{ item.isActive }}</td>
                `,
        setup(props) {

            return {
            }
        }
    });

    const vm = app.mount('#app');
</script>
```