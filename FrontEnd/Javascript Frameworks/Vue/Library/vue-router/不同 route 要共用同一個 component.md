# 不同 route 要共用同一個 component

不同 route 間，直接切換至同一個 component，預設不會 reload !

要達到 component reload，可以用下面的語法 !

加上 `:key="$route.fullPath"` 就可以了 !

```html
<router-view :key="$route.fullPath"/>
```
