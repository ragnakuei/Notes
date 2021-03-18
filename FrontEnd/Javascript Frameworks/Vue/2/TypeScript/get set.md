# get set

- get、set 不能與 @Prop 混用
- 主要運用範圍在 component 內的 computed 
- get、set 可以指派不同的存取權限，但 存取權限好像沒用 && eslint 會報錯

## 範例

component

```html
<template>
    <div>
        <p>
            <label>First Name:</label>
            <input :value="firstName">
        </p>
        <p>
            <label>Last Name:</label>
            <input :value="lastName">
        </p>
        <p>
            <label>Full Name:</label>
            <input :value="fullName">
        </p>
    </div>
</template>

<script lang="ts">
    import { Component, Prop, Vue } from "vue-property-decorator";

    @Component
    export default class TestChild3 extends Vue {
        constructor() {
            super();

            this.firstName = 'firstName';
            this.lastName = 'lastName';
            this.fullName = "z x";
        }

        public set fullName(newValue: string) {
            console.log(`fullName:${newValue}`)

            const names = newValue.split(' ');

            if (names.length === 2) {
                this.firstName = names[0];
                this.lastName = names[1];
            }
        }

        public get fullName(): string {
            return `${ this.firstName } ${ this.lastName }`;
        }

        private firstName: string;
        private lastName: string;
    }
</script>
```
