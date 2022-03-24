# subscript route

- subscribe events 會有很多種事件，其中最後一個就是 type NavigationEnd
- type NavigationEnd 則是 route 變更的最後一個事件

```ts
Router.events.subscribe((e) => {
    if (e instanceof NavigationEnd) {
        this.updateMenuItems(e.url);
    }
});
```