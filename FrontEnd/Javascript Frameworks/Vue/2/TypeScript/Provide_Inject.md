# Provide_Inject

- Provide 與 Inject 為成雙成對的，透過相同的 string key 來放入及取出 資料
- Provide 放入資料
- Inject 取出資料
- Inject Field 為 immutable ，不可以有任何動作會去改變 field 的值

## 範例

Parent Component

```html
<template>
    <div>
        <p>TestChild5</p>
        <TestChild5 />
    </div>
</template>
<script lang="ts">
    import { Component, Provide, Vue } from "vue-property-decorator";
    import TestChild5 from "@/views/TestChild5.vue";

    @Component({
        components: { TestChild5   }
    })
    export default class Test extends Vue {

        constructor() {
            super();

            this.firstName = "A";
            this.lastName = "B";
        }

        @Provide('fistName')
        private firstName: string;

        @Provide('lastName')
        private lastName: string;
    }
</script>
```

Child Component

因為 Inject field 為 immutable ，所以通常就會給定 ! 以略過初始化的判斷

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
    import { Component, Inject, Vue } from "vue-property-decorator";

    @Component
    export default class TestChild5 extends Vue {
        constructor() {
            super();
        }

        @Inject('fistName')
        private firstName!: string;

        @Inject('lastName')
        private lastName!: string;

        private get fullName(): string {
            return `${ this.firstName } ${ this.lastName }`;
        }
    }
</script>
```