# 以 vue 來 submit


```html
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