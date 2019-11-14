# [Route](https://angular.io/guide/router)

## [Router outlet](https://angular.io/guide/router)

## [routerLink](https://angular.io/guide/router#router-links)

會比對 Routes 的設定值，如果不一致的話，Console 會有錯誤訊息，而且不會轉頁

```html
<nav>
    <a routerLink='' routerLinkActive='active' [routerLinkActiveOptions]="{exact: true}">Home</a>
    <a routerLink='order/list' routerLinkActive='active'>Orders</a>
</nav>
```

## [navigate](https://angular.io/api/router/Router#navigate)

Sample

```typescript
constructor(private orderService: OrderService,
    private router: Router,
    private route: ActivatedRoute) {
}

this.router.navigate(['/order/'+ orderId]);
this.router.navigate(['../order', orderId], { relativeTo: this.route });
```