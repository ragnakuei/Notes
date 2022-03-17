# 強制 rerender template 的做法

參考資料

- [How to force a component's re-rendering in Angular 2?](https://stackoverflow.com/questions/35105374/how-to-force-a-components-re-rendering-in-angular-2)

> ApplicationRef.tick()

> NgZone.run(callback)

> ChangeDetectorRef.detectChanges()

> ChangeDetectorRef.markForCheck()

