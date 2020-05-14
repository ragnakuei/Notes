# Fragment

```typescript
this.route.fragment.subscribe((fragment: string) => {
  console.log("My hash fragment is here => ", fragment);
});
```

```html
<button
mat-button
[routerLink]="['/order/detail/', order.OrderID]"
fragment="readonly"
routerLinkActive="active"
color="primary"
>
Detail
</button>
```
