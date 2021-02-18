# Watch

- 加到 watch 的 field，在設定資料時，就會觸發所指定的 event
- 一次可加多組 field


## 範例

只要 fistName 或 lastName 有變更，就會呼叫 `onChildChanged()` method

```html
<template>
    <div>
        <p>
            <label>FirstName:</label>
            <label>
                <input :value="firstName"/>
            </label>
        </p>

        <p>
            <label>LastName:</label>
            <label>
                <input :value="lastName"/>
            </label>
        </p>

        <p>
            <label>FullName:</label>
            <label>
                <input :value="fullName"/>
            </label>
        </p>

        <p>
            <button @click="onClickButton()">Click</button>
        </p>

    </div>
</template>
<script lang="ts">
    import { Component, Vue, Watch } from "vue-property-decorator";

    @Component({
        components: {  }
    })
    export default class Test extends Vue {

        private firstName: string;
        private lastName: string;
        private fullName: string;

        constructor() {
            super();

            this.firstName = '';
            this.lastName = '';
            this.fullName = '';
        }

        @Watch('firstName')
        @Watch('lastName')
        onChildChanged(val: string, oldVal: string) {
            console.log(`newValue:${ val }`);
            console.log(`oldValue:${ oldVal }`);

            this.fullName = `${this.firstName} ${this.lastName}`;
        }

        private onClickButton(): void {
            console.log('onClickButton');

            this.firstName = 'A';
            this.lastName = 'B';
        }
    }
</script>
```

