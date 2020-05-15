# [v-for](https://vuejs.org/v2/guide/list.html)

- [v-for](#v-for)
  - [Object](#object)
    - [取值](#%e5%8f%96%e5%80%bc)
    - [取值及 property name](#%e5%8f%96%e5%80%bc%e5%8f%8a-property-name)
    - [取值、property name 及 index](#%e5%8f%96%e5%80%bcproperty-name-%e5%8f%8a-index)
  - [Array](#array)
    - [取值](#%e5%8f%96%e5%80%bc-1)
    - [取值及 index](#%e5%8f%96%e5%80%bc%e5%8f%8a-index)
    - [套用至 v-bind](#%e5%a5%97%e7%94%a8%e8%87%b3-v-bind)
  - [attribute](#attribute)
    - [自訂 attribute](#%e8%87%aa%e8%a8%82-attribute)

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

### 取值、property name 及 index

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

### 套用至 v-bind 

```html
<template>
    <div>
        <checkedButton v-for="value in buttons" 
                       v-bind:id="value.id" 
                       v-bind:initialChecked="value.isChecked" 
                       v-on:onButtonClick="checkedButtonClick" />
    </div>
</template>

<script>
    import checkedButton from "@/views/CheckedButton.vue"
    
    export default {
        components : {
            checkedButton
        },
        props:[
        ],
        data() {
            return {
                buttons : [
                    {id : 1, isChecked : false},
                    {id : 2, isChecked : true},
                    {id : 3, isChecked : false},
                ]
            }
        },
        methods : {
            checkedButtonClick : function(target) {
                console.log(target);
            }
        }
    } 
</script>
```

---

## attribute

### 自訂 attribute

下面範例的 test

```html
<template>
    <div>
        <checkedButton v-for="value in buttons"
                       :test = " 'id' + value.id" 
                       v-bind:id="value.id" 
                       v-bind:initialChecked="value.isChecked" 
                       v-on:onButtonClick="checkedButtonClick" />
    </div>
</template>
```

就可以得到 id1、id2、id3

```html
<div data-v-7ba5bd90="">
  <button test="id1">Checked : false</button>
  <button test="id2">Checked : true</button>
  <button test="id3">Checked : false</button>
</div>
```