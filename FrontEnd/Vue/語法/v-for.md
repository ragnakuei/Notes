# [v-for](https://vuejs.org/v2/guide/list.html)

- [v-for](#v-for)
  - [Object](#object)
    - [取值](#%e5%8f%96%e5%80%bc)
    - [取值及 property name](#%e5%8f%96%e5%80%bc%e5%8f%8a-property-name)
    - [取值、欄位名稱 及 index](#%e5%8f%96%e5%80%bc%e6%ac%84%e4%bd%8d%e5%90%8d%e7%a8%b1-%e5%8f%8a-index)
  - [Array](#array)
    - [取值](#%e5%8f%96%e5%80%bc-1)
    - [取值及 index](#%e5%8f%96%e5%80%bc%e5%8f%8a-index)

---

## Object

### 取值

```html
<ul>
  <li v-for="value in getUser">
    {{value}}
  </li>
</ul>
```

### 取值及 property name

```html
<ul>
  <li v-for="(value, name) in getUser">
    {{index}} - {{name}}
  </li>
</ul>
```

### 取值、欄位名稱 及 index

```html
<ul>
  <li v-for="(value, name, index) in getUser">
    {{index}} - {{name}} - {{value}}
  </li>
</ul>
```

---

## Array

### 取值

```js
<template>
    <div>
        <h1>Users</h1>
        <table>
            <thead>
            <tr>
                <td>Name</td>
                <td>Age</td>
            </tr>
            </thead>
            <tbody>
            <tr v-for="user in getUsers">
                <td>{{user.name}}</td>
                <td>{{user.age}}</td>
            </tr>
            </tbody>
        </table>
    </div>
</template>

<script>
    import users from '@/data/users.json';

    export default {
        name: "users",
        computed: {
            getUsers() {
                console.log(users);
                return users;
            }
        }
    };
</script>
```

### 取值及 index

```html
<tr v-for="(user, index) in getUsers">
  <td>{{index}}</td>
  <td>{{user.name}}</td>
  <td>{{user.age}}</td>
</tr>
```
