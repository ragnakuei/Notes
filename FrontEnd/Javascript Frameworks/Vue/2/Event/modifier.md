# [modifier](https://vuejs.org/v2/guide/events.html#Event-Modifiers)

## form prevent sample

```js
Vue.component("product", {
  template: `
    <div>
      <form @submit.prevent="onSubmit">
        <p>
          <label for="userName">UserName</label>
          <input name="userName" v-model="userName" />
        </p>
        <p>
          <label for="password">Password</label>
          <input type="password" name="password" v-model="password" />
        </p>
        <p>
          <input type="submit" value="submit" />
        </p>
      </form>
    </div>
  `,
  data() {
    return {
        userName: "",
        password: "",
    };
  },
    methods: {
        onSubmit(e) {
            console.log(e);

            const postBody = {
                UserName: this.userName,
                Password: this.password,
            };

            console.log(postBody);

            this.userName = null;
            this.password = null;
        },
    },
});
```