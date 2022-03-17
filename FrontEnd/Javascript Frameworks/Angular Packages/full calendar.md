# [full calendar](https://fullcalendar.io/docs)

[範例](https://stackblitz.com/github/fullcalendar/fullcalendar-example-projects/tree/master/angular)

#### CalendarOptions


```js
  calendarOptions: CalendarOptions = {
    timeZone: 'Asia/Taipei',
    // locales: [zhTwLocale],
    // locale: 'zh-tw',
    initialView: 'dayGridMonth',
    headerToolbar: {
      left: 'titleButton title prev,next',
      right: 'setupDefaultDayButton, batchSetupButton',
    },
    customButtons: {
      titleButton: {
        text: '',
      },
      setupDefaultDayButton: {
        text: '設定預設天數',
      },
      batchSetupButton: {
        text: '批次設定',
      },
    },
    eventMinWidth: 10,
    
    // 讓 table 可以被範圍選取
    selectable: true,
    
    // 範圍選取的事件
    select: (arg) => this.select(arg),

    // 點擊日期的事件
    dateClick: (info) => this.createEvent(info),
  };
```

#### [title format](https://fullcalendar.io/docs/titleFormat)

#### [locale](https://fullcalendar.io/docs/locale)

```ts
import zhTwLocale from '@fullcalendar/core/locales/zh-tw';

calendarOptions: CalendarOptions = {
    timeZone: 'Asia/Taipei',
    locales: [zhTwLocale],
    locale: 'zh-tw',
    initialView: 'dayGridMonth',
    headerToolbar: {
        left: 'titleButton title prev,next',
    },
};
```

#### [dateClick](https://fullcalendar.io/docs/dateClick)

- 參數：DateClickArg
  - data 
    - 日期型式
  - dateStr
    - 字串型式
  - view
    - 型別：ViewApi
    - 有該日的許多資訊可以抓出來用
    


```ts
createEvent(eventArg: DateClickArg): void { 
    
}
```


#### [select](https://fullcalendar.io/docs/select-callback)

- DateSelectArg
  - start 
    - 日期型式
  - end
    - 日期型式
  - startStr
    - 字串型式
  - endStr
    - 字串型式
  - allDay
  - view
    - 型別：ViewApi
    - 有該日的許多資訊可以抓出來用

```ts
select(arg: DateSelectArg): void {
    console.log('select', arg.start);
    console.log('select', arg.end);
    console.log('select', arg.startStr);
    console.log('select', arg.endStr);
    console.log('select', arg.allDay);
    console.log('select', arg.view);
}
```


```ts
this.calendar = this.calendarComponent?.getApi();
this.calendar.gotoDate(new Date());
```