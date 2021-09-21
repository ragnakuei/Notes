# 支援 sass

安裝 sass 

- 在專案目錄內，執行以下指令
    > npm install -D sass

style 後面就可以加上 lang="sass"  或 lang="scss"

#### sass

可以從其他 sass 檔 import sass 檔

```html
<style scoped lang="sass">
@import "./HelloWorld.sass"

a 
  color: $mainColor

</style>
```

```scss
$mainColor: #42b983
```

#### scss

可以從其他 scss 檔 import scss 檔

```html
<style scoped lang="scss">
@import "./HelloWorld.scss";

a {
  color: $mainColor;
}
</style>
```
HelloWorld.scss

```scss
$mainColor: #42b983;
```
