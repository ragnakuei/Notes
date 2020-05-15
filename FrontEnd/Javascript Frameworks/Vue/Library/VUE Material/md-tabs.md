# md-tabs

- [md-tabs](#md-tabs)
  - [增加 route 的方式](#%e5%a2%9e%e5%8a%a0-route-%e7%9a%84%e6%96%b9%e5%bc%8f)

---

## 增加 route 的方式

原本 route 設定語法如下

```html
<router-link to="/">Home</router-link>
```

md-tabs 要增加 route 的語法，只要從 

```html
<md-tab id="tab-home" md-label="Home"></md-tab>
```

加上與 router-link 相同的 attribute `to=""` 的 attribute 就可以了

```html
<md-tab id="tab-home" md-label="Home" to="/"></md-tab>
```

這樣就可以了
