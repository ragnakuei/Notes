# sync

```js
const {createApp, ref, reactive, onMounted, computed} = Vue;

createApp({
    template: `
        <div>
        <p>counter outer: {{ counter }}</p>
        
        <counter v-bind:counter.sync="counter" ></counter>
        <!-- ↓ 這一行等於上面一行 -->
        <
        <counter v-bind:counter="counter"  v-on:update:counter="v => counter = v" ></counter>
        </div>
    `,
    data() {
        return {
            counter: 0,
        }
    },
}).component('counter', {
    template: `
        <div>
        <p>innerCounter: {{ innerCounter }}</p>
        <button @click="innerCounter++">+</button>
        <button @click="sync" >sync</button>
        </div>
    `,
    props: ['counter'],
    data() {
        return {
            innerCounter: this.counter,
        }
    },
    methods: {
        sync() {
            this.$emit('update:counter', this.innerCounter);
        }
    }
}).mount('#app');
```