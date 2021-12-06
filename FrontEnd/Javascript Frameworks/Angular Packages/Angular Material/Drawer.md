# Drawer

與 SideNav 極為類似，但不包含 viewport 相關功能。

可以視為 SideNav 的縮小區域的版本。


```html
<mat-drawer-container class="example-container">
    <mat-drawer mode="side" opened>
        <!-- 左方選單 -->
        <app-side-menu></app-side-menu>
    </mat-drawer>
    <mat-drawer-content>
        <!-- 右方內容 -->
        <router-outlet></router-outlet>
    </mat-drawer-content>
</mat-drawer-container>
```