# root url 都會有 css class active

當設定 route 為 `{ path: '', component: HomeComponent }` 時
任何 route 都會讓上的 route 都帶出 css class active
而且實際上的需求是，只有 mapping 到的 route 才能顯示 css class active

調整方式

```html
<nav>
    <a routerLink=''
       routerLinkActive='active'

       [routerLinkActiveOptions]="{exact: true}"
       <!-- 加上此 attribute 就可以了 -->

       >Home</a>
    <a routerLink='order/list' routerLinkActive='active'>Orders</a>
</nav>
```
