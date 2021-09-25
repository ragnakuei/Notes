# 更新狀態後 出現 ExpressionChangedAfterItHasBeenCheckedError

#### 範例一

登出後，更新 UserInfoDto，透過 subscribe UserInfoDtoChange，讓 Nav 可以重新依照 UserInfoDto.Role 來更新 !

> Nav 在 app.compoonent 中

然而登出的做法是：切換至登入頁，在登入頁中，清除 UserInfoDto

解決方式：

在 app.component 中加上以下部份語法：

```js
// 加上引用
import { ChangeDetectorRef } from '@angular/core';

export class AppComponent {

    constructor(private _jwtStore: JwtStore,
                private _router: Router,

                // 加上這行
                private _changeDetectorRef: ChangeDetectorRef) {
    }

    private userInfoDto: IUserInfoDto = new UserInfoDto();

    ngOnInit(): void {
        UserInfoDtoStore.UserInfoDtoChange
                        .subscribe((value: IUserInfoDto) => {
                            this.userInfoDto = value;
                        });
    }

    // 加上這一段
    ngAfterViewChecked(): void {
        this._changeDetectorRef.detectChanges();
    }
}
```


