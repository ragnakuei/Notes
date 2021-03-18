# [Sidenav](https://material.angular.io/components/sidenav/api)

> import { MatSidenavModule } from "@angular/material/sidenav";

搭配 toolbar 的語法結構

說明

- 於 mat-sidenav 內，以 # 開頭宣告 id，該 id 就可以在 view 中重複被使用

```html
<mat-toolbar class="example-header" color="primary">
  <mat-toolbar-row>
    <button mat-icon-button (click)="sideNav.toggle()">
      <mat-icon>{{ sideNav.opened ? "close" : "menu" }}</mat-icon>
    </button>

    <button
      mat-button
      routerLink=""
      routerLinkActive="active"
      [routerLinkActiveOptions]="{ exact: true }"
    >
      Home
    </button>
    <button mat-button routerLink="order" routerLinkActive="active">
      Orders
    </button>
  </mat-toolbar-row>
</mat-toolbar>
<mat-sidenav-container>
  <mat-sidenav #sideNav mode="push">
    <p>
      <a
        routerLink=""
        routerLinkActive="active"
        [routerLinkActiveOptions]="{ exact: true }"
        >Home</a
      >
    </p>
    <p>
      <a routerLink="order" routerLinkActive="active">Orders</a>
    </p>
  </mat-sidenav>

  <mat-sidenav-content>
    <router-outlet></router-outlet>
  </mat-sidenav-content>
</mat-sidenav-container>
<mat-toolbar>Footer</mat-toolbar>
```

注意事項：

- \<mat-sidenav-container> 內，只能有一組 \<mat-sidenav>

## method

- toggle()

- open()

- close()

## directive

- mode

  | 值   | 效果說明                                                                                                                                |
  | ---- | --------------------------------------------------------------------------------------------------------------------------------------- |
  | over | 預設值。會以 lightbox 的效果，讓 sidevar 浮動跳出。按下 \<esc> 或是 \<mat-sidenav-content> 內的地方，就會隱藏。                         |
  | side | 不會以 lightbox 的效果，讓 sidevar 跳出，會將 \<mat-sidenav-content> 往右推。                                                           |
  | push | 會以 lightbox 的效果，讓 sidevar 跳出，會將 \<mat-sidenav-content> 往右推。按下 \<esc> 或是 \<mat-sidenav-content> 內的地方，就會隱藏。 |

- disabledClose

  在 mode 設定成 over 或是 push 時，如果不想要有 按下 \<esc> 或是 \<mat-sidenav-content> 內的地方，就會隱藏 的功能，可以透過這個 directive 來達成。

  使用此 directive 時，就會建議要自己實作 將 sidenav 關閉 的功能。

- position

  | 值    | 效果說明             |
  | ----- | -------------------- |
  | start | 預設值。通常是左邊。 |
  | end   | 通常是右邊。         |

- fixedInViewport

  | 值    | 效果說明                                                                                                |
  | ----- | ------------------------------------------------------------------------------------------------------- |
  | false | 預設值                                                                                                  |
  | true  | 這個設定會讓 sidenav 固定在 viewport 上，就有可能會蓋到 toolbar 的區域。搭配 mode="over" 比較不會太突兀 |

- fixedTopGap

  在 fixedInViewport 設定成 true 時，與 viewport top 的距離。

- fixedBottomGap

  在 fixedInViewport 設定成 true 時，與 viewport bottom 的距離。
