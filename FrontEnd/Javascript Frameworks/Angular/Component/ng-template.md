# ng-template

- 類似 vue 的 template
- 搭配其他 directive 語法時，syntax 有些不同
  - *ngIf 要改用 [nfIf]
  - *ngFor 要改用以下的語法
    - [ngFor] 代表要使用 *ngFor
    - let-itemName - itemName 可自訂
    - [ngForOf]="arrayVariable" - arrayVariable 就是陣列變數
    - let-i="index" - 指定 i 為 index


#### 範例一

template

```html
<div id="nav">
    <a routerLink="/">Home</a>
    |
    <ng-template ngFor
                 let-routeDto
                 [ngForOf]="mainNav"
                 let-i="index">
        <ng-template [ngIf]="routeDto.Enable">
            <a [routerLink]="routeDto.Url">{{ routeDto.Text }}</a>
            |
        </ng-template>
    </ng-template>
</div>
<div id="sub_nav"
     *ngIf="isLogin">
    <ng-template ngFor
                 let-subRouteDto
                 [ngForOf]="subNav"
                 let-i="index">
        <ng-template [ngIf]="subRouteDto.Enable">
            <span *ngFor="let subRoute of subRouteDto.Nav">
                <a [routerLink]="subRoute.Url">{{ subRoute.Text }}</a> |
            </span>
        </ng-template>
    </ng-template>
</div>

<router-outlet></router-outlet>
```



component

```ts
@Component({
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: [ './app.component.css' ]
})
export class AppComponent {

    constructor(private userInfoDtoStore: UserInfoDtoStore,
                private jwtStore: JwtStore,
                private router: Router) {
    }

    ngOnInit(): void {

    }

    get isLogin() {
        return this.userInfoDtoStore.UserInfoDto.Guid?.length > 0
                    && this.jwtStore.RefreshToken?.length > 0;
    }

    get roleIsManager() {
        return this.isLogin
            && this.userInfoDtoStore.UserInfoDto?.Role === RoleConst.Manager;
    }

    get roleIsUser() {
        return this.isLogin
            && this.userInfoDtoStore.UserInfoDto?.Role === RoleConst.User;
    }

    get mainNav() {
        return [
            {
                Enable: this.isLogin === false,
                Text: "登入",
                Url: '/Account/Login'
            },
            {
                Enable: this.roleIsManager,
                Text: "管理者首頁",
                Url: '/Manager'
            },
            {
                Enable: this.roleIsManager,
                Text: "會議室",
                Url: '/MeetingRoom'
            },
            {
                Enable: this.roleIsManager,
                Text: "可預約時段",
                Url: '/Reservable'
            },
            {
                Enable: this.roleIsUser,
                Text: "使用者首頁",
                Url: '/User'
            },
            {
                Enable: this.roleIsUser,
                Text: "預約會議室",
                Url: '/Booking'
            },
            {
                Enable: this.isLogin,
                Text: "登出",
                Url: '/Account/Logout'
            },
        ];
    }


    get subNav() {
        return [
            {
                Text: "會議室",
                Enable: this.roleIsManager
                    && this.router.url.includes('/MeetingRoom'),
                Nav: [
                    {
                        Text: "首頁",
                        Url: '/MeetingRoom',
                    },
                    {
                        Text: "新增",
                        Url: '/MeetingRoom/Add',
                    },
                ],
            },
            {
                Text: "可預約時段",
                Enable: this.roleIsManager
                    && this.router.url.includes('/Reservable'),
                Nav: [
                    {
                        Text: "首頁",
                        Url: '/Reservable',
                    },
                    {
                        Text: "新增",
                        Url: '/Reservable/Add',
                    },
                ],
            },
            {
                Text: "預約會議室",
                Enable: this.roleIsUser
                    && this.router.url.includes('/Booking'),
                Nav: [
                    {
                        Text: "首頁",
                        Url: '/Booking',
                    },
                    {
                        Text: "新增",
                        Url: '/Booking/Add',
                    },
                ],
            },
        ];
    }
}
```