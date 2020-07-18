# codepen 範例

在 html 最上方，可直接引用 vue 的 script

也可以在 js 的 extend js 使用 vue 的 script

```html
<script src="https://unpkg.com/vue"></script>

<div id="men">

  {{log}}
  <form v-on:submit.prevent="sub" action="#" method="post">

    <p>
      <input v-model="userName" placeholder="Username">
    </p>
    <p>
      <input v-model="password" placeholder="Password">
    </p>
    <p>
      <button type="submit">Entrar</button>
    </p>
  </form>

</div>
```

```js
new Vue({
  el: "#men",

  data:{
      userName: "",
      password: "",
      log: ""
  },
  
  methods: {
      
      sub: function(event){
          
          if(this.userName == "" || this.password == ""){
            
            this.log = "Please input username and password !";
            // event.preventDefault();
          }else{
            this.log = "Go";
          }   
      }
  }
  
});
```