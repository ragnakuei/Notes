# binding

- [binding](#binding)
  - [範例 - Property Binding](#範例---property-binding)
  - [範例 - Event Binding](#範例---event-binding)

---

`{{  }}` 裡面是放 expression 

---

## 範例 - Property Binding


```html
<template>
    <div>
        <p>Order</p>
        <div>{{ firstName + ' ' + lastName }}</div>
        <div>{{ fullName() }}</div>
    </div>
</template>

<script>
    export default {
        name: 'order',
        components: {},
        data() {
            return {
                firstName: 'Foo',
                lastName: 'Bar',
            }
        },
        methods : {
            fullName() {
                return this.firstName + ' ' + this.lastName;
            }
        }
    }
</script>
```

---

## 範例 - Event Binding

```html
<template>
    <button @click="count++">You clicked me {{ count }} times.</button>
    <!-- 另一種寫法 -->
    <!-- <button v-on:click="count++">You clicked me {{ count }} times.</button> -->
</template>

<script>
    export default {
        data() {
            return {
                count: 0
            }
        }
    }
</script>
```

