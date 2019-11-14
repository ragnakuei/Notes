# root url 都會有 class active

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