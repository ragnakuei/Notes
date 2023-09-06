# date picker

## sample01

- 不做驗證

呼叫語法

```html
<div>
    <label for="booking_date">日期</label>
    <vue_date_picker v-model="booking_date"
                     id="booking_date"
                     format="YYYY-MM-DD"
                     min-date="2021-12-10"
                     max-date="2024-01-10"
                     v-on:validate-fail="validateFail()"
    >
    </vue_date_picker>
</div>
```

component

```js
const vue_date_picker = {
  template: `
<div class="vue-date-picker-calendar"
    v-bind:class="divClass">
    <input v-bind:id="id"
           v-model="domValue"
           v-on:focus="focusInput"
           v-on:blur="blurInput"
           v-on:keydown="keydownNav"
           v-bind:readonly="!showCalendar"
           v-bind:style="{ zIndex: showCalendar ? '100' : '0' }"
           placeholder="x"
          />
    
    <div class="calendar-wrapper" v-if="showCalendar">
        <div class="calendar">
            <div class="calendar-header" 
                 v-on:keydown="keydownNav">
                <div class="year">
                    <div class="calendar-nav-wrapper">
                        <button type="button"
                                ref="prevYear"
                                class="calendar-nav"
                                v-on:click="toViewOffsetYear(-1)">
                                &lt;
                        </button>
                    </div>
                        {{ calendarObj.currentYear }}
                    <div class="calendar-nav-wrapper">
                        <button type="button"
                                ref="nextYear"
                                class="calendar-nav"
                                v-on:click="toViewOffsetYear(1)">
                                &gt;
                        </button>
                    </div>
                </div>
                <div class="month">
                    <div class="calendar-nav-wrapper">
                        <button type="button" 
                                ref="prevMonth"    
                                class="calendar-nav"
                                v-on:click="toViewOffsetMonth(-1)">
                                &lt;
                        </button>
                    </div>
                        {{ ('0' + calendarObj.currentMonth).slice(-2) }}
                    <div class="calendar-nav-wrapper">
                        <button type="button"
                                ref="nextMonth"
                                class="calendar-nav"
                                v-on:click="toViewOffsetMonth(1)">
                                &gt;
                        </button>
                    </div>
                </div>
            </div>
            <div class="week">
                <div v-for="weekLabel in weekLabels">
                    {{ weekLabel }}
                </div>
            </div>
            <div class="days">
                <template v-for="dayObj in calendarObj.calendarDays">
                    <div class="day allow"
                        v-if="allowSelectDay(dayObj)"
                        v-bind:class="dayClass(dayObj)"
                        v-on:click="clickCalendarDay(dayObj)"
                        >
                        {{ dayObj.day }}
                    </div>
                    <div v-else
                        class="day disallow"
                        v-bind:class="dayClass(dayObj)"
                        >
                        <span>{{ dayObj.day }}</span>
                        <span></span>
                    </div>
                </template>
            </div>
        </div>
        <div class="tool-bar" v-if="showCalendar">
            <button type="button" v-on:click="selectToday()"> Today </button>
        </div>
    </div>
    <div v-if="showCalendar"
        class="wrapper-overlay"
        v-on:click="closeCalendar()">
        <!-- 全畫面蓋版 -->
    </div>
    <span class="invalid-feedback">
        
    </span>
</div>
        `,
  props: {
    divClass: String,
    label: String,
    format: String,
    id: String,
    modelValue: String,
    minDate: String,
    maxDate: String,
  },
  setup(props, { emit }) {
    const domField = ref({});
    domField.value = (toDayjs(props.modelValue) || dayjs()).format(props.format);

    // 類型：字串，要經過 dayjs 的轉換
    const domValue = computed({
      get: () => {
        return domField.value;
      },
      set: (v) => {
        domField.value = v;
        emit("update:modelValue", v);
      },
    });

    const minDateInDayjs = ref(null);
    if (props.minDate) {
      minDateInDayjs.value = toDayjs(props.minDate);
    }

    const maxDateInDayjs = ref(null);
    if (props.maxDate) {
      maxDateInDayjs.value = toDayjs(props.maxDate);
    }

    // 整個日曆物件，以 dayjs 為基礎
    const calendarObj = ref();

    // 目前顯示日
    const viewDateInDayjs = computed({
      get: () => {
        return calendarObj.value.currentDate;
      },
      set: (v) => {
        calendarObj.value = getCalendarByDayjs(v, props.format, dayjs(domValue.value));
      },
    });

    const initialCalendar = function () {
      viewDateInDayjs.value = toDayjs(domValue.value) || dayjs();
    };
    initialCalendar();

    const focusInput = function () {
      initialCalendar();
      openCalendar();
    };

    const blurInput = function () {
    //   console.log("blurInput");
      initialCalendar();
      syncDomValueWithDayjs();
    };

    const keydownNav = function (e) {
    //   console.log('keydownNav');
      if (e.keyCode === 38) {
        // up
        prevMonth.value?.focus();
        prevMonth.value?.click();
      } else if (e.keyCode === 40) {
        // down
        nextMonth.value?.focus();
        nextMonth.value?.click();
      } else if (e.keyCode === 33) {
        // pageUp
        prevYear.value?.focus();
        prevYear.value?.click();
      } else if (e.keyCode === 34) {
        // pageDown
        nextYear.value?.focus();
        nextYear.value?.click();
      }
    };

    const showCalendar = ref(false);
    const openCalendar = function () {
      showCalendar.value = true;
    };
    const closeCalendar = function () {
      showCalendar.value = false;
      validateInput();
    };

    const dayClass = function (dayObj) {
      return {
        "in-month": dayObj.isViewMonth,
        "not-in-month": !dayObj.isViewMonth,
        "is-today": allowSelectDay(dayObj) && dayObj.dayInDayjs.isSame(dayjs(), "day"),
        "is-selected-day": dayObj.dayInDayjs.isSame(dayjs(domValue.value)),
      };
    };

    const allowSelectDay = function (dayObj) {
      if (minDateInDayjs.value.isValid() && dayObj.dayInDayjs.isBefore(minDateInDayjs.value)) {
        return false;
      }

      if (maxDateInDayjs.value.isValid() && dayObj.dayInDayjs.isAfter(maxDateInDayjs.value)) {
        return false;
      }

      return true;
    };

    const clickCalendarDay = function (dayObj) {
      //   console.log("clickCalendarDay", dayObj);
      domValue.value = dayObj.dayInDayjs.format(props.format);
      closeCalendar();
    };

    const prevYear = ref(null);
    const nextYear = ref(null);
    const prevMonth = ref(null);
    const nextMonth = ref(null);

    // 是否顯示上一年
    const showPrevYear = computed(() => {
      if (minDateInDayjs.value.isValid()) {
        return viewDateInDayjs.value.year() > minDateInDayjs.value.year();
      }

      return true;
    });
    // 是否顯示下一年
    const showNextYear = computed(() => {
      if (maxDateInDayjs.value.isValid()) {
        return viewDateInDayjs.value.year() < maxDateInDayjs.value.year();
      }

      return true;
    });

    // 上/下一年 - 暫時不用，影響鍵盤做 keydownNav
    const toViewOffsetYear = function (v) {
      viewDateInDayjs.value = viewDateInDayjs.value.add(v, "Year");
    };

    // 是否顯示上一月 - 暫時不用，影響鍵盤做 keydownNav
    const showPrevMonth = computed(() => {
      if (minDateInDayjs.value.isValid()) {
        if (viewDateInDayjs.value.year() > minDateInDayjs.value.year()) {
          return true;
        }

        return (
          viewDateInDayjs.value.year() >= minDateInDayjs.value.year() &&
          viewDateInDayjs.value.month() > minDateInDayjs.value.month()
        );
      }

      return true;
    });
    // 是否顯示下一月
    const showNextMonth = computed(() => {
      if (maxDateInDayjs.value.isValid()) {
        if (viewDateInDayjs.value.year() < maxDateInDayjs.value.year()) {
          return true;
        }

        return (
          viewDateInDayjs.value.year() <= maxDateInDayjs.value.year() &&
          viewDateInDayjs.value.month() < maxDateInDayjs.value.month()
        );
      }

      return true;
    });

    // 上/下一月
    const toViewOffsetMonth = function (v) {
      viewDateInDayjs.value = viewDateInDayjs.value.add(v, "Month");
    };
    // 移至 Offset 天
    const toViewOffsetDay = function (v) {
      viewDateInDayjs.value = viewDateInDayjs.value.add(v, "Day");
    };

    // 選擇今天
    const selectToday = function () {
      domValue.value = dayjs().format(props.format);
      initialCalendar();
    };

    // 驗證輸入
    const validateInput = function () {
      const domValueInDayjs = toDayjs(domValue.value);
      if (!domValueInDayjs.isValid() || minDateInDayjs.value > domValueInDayjs || maxDateInDayjs.value < domValueInDayjs) {
        emit("validate-fail", domValue.value);
        console.log("validate-fail");
        return;
      }

      syncDomValueWithDayjs();

      console.log("validate success");
    };

    // 將 domValue 與 dayjs 同步 - 因為 dayjs 會自動補齊日期，例如 2021-02-31 會變成 2021-03-03
    function syncDomValueWithDayjs() {
      domValue.value = dayjs(domValue.value).format(props.format);
    }

    onMounted(() => {});

    return {
      domValue,
      calendarObj,
      weekLabels: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"],
      focusInput,
      blurInput,
      keydownNav,
      showCalendar,
      openCalendar,
      closeCalendar,
      dayClass,
      allowSelectDay,
      clickCalendarDay,
      prevYear,
      nextYear,
      prevMonth,
      nextMonth,
      showPrevYear,
      showNextYear,
      toViewOffsetYear,
      showPrevMonth,
      showNextMonth,
      toViewOffsetMonth,
      selectToday,
    };
  },
};

```
 共用 js

```js
function getCalendarByDayjs(currentDate) {
  const currentYear = currentDate.get("year");
  const currentMonth = currentDate.get("month") + 1;

  // 該月第一天
  const firstDayOfMonth = currentDate.startOf("month");
  // 該月最後一天
  const lastDayOfMonth = currentDate.endOf("month");

  // 日曆上的第一天，可能會是上個月的
  const firstDayOfCalendar = firstDayOfMonth.subtract(firstDayOfMonth.get("day"), "day");

  // 橫跨週數，要加上該週上月的天數再除以 7
  const weeks = Math.ceil((currentDate.daysInMonth() + firstDayOfMonth.get("day")) / 7);
  const calenderTotalDays = weeks * 7;

  // 日曆上的最後一天，可能會是下個月的
  const lastDayOfCalendar = firstDayOfCalendar.add(weeks * 7 - 1, "day");

  // 產生日曆上的日期，以 7 * weeks 的陣列表示
  const calendarWeeks = Array.from({ length: weeks }, (_, w) => {
    const firstDayOfWeek = firstDayOfCalendar.add(w, "week");
    return Array.from({ length: 7 }, (_, d) => {
      const day = firstDayOfWeek.add(d, "day");

      return {
        // 該日以 dayjs 表示
        dayInDayjs: day,

        // 該日的年、月、日
        year: day.get("year"),
        month: day.get("month") + 1,
        day: day.get("date"),

        // 該日是星期幾
        week: day.get("day"),

        // 該日是否為顯示的月份
        isViewMonth: currentDate.get("month") === day.get("month"),
      };
    });
  });

  // 把 7 * weeks 的陣列展開(攤平)成一個陣列
  const calendarDays = calendarWeeks.reduce((prev, current) => {
    prev.push(...current);
    return prev;
  }, []);

  return {
    currentDate,
    currentYear,
    currentMonth,
    firstDayOfMonth,
    lastDayOfMonth,
    weeks,
    calenderTotalDays,
    firstDayOfCalendar,
    lastDayOfCalendar,
    calendarWeeks,
    calendarDays,
  };
}

// 如果 v 是有效的，則回傳 dayjs，否則回傳 null
function toDayjs(v) {
  return dayjs(v).isValid() ? dayjs(v) : null;
}
```

style


```css
.vue-date-picker-calendar {
  position: relative;
}

.vue-date-picker-calendar .calendar-wrapper {
  background: #fff;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  z-index: 99;
  border: 1px solid #747474;
  border-radius: 6px;
  box-shadow: 10px 10px 20px #e4e4e4;
  padding: 10px;
  
  position: absolute;
  top: 31px;
}

.vue-date-picker-calendar .calendar {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;

  min-width: 350px;
  width: 350px;

  overflow: hidden;
}

.vue-date-picker-calendar .calendar-header {
  background: #7548ff;
  color: white;
  border-radius: 6px;
  display: flex;
  flex-direction: row;
  justify-content: center;
  gap: 30px;
  align-items: center;
  flex-wrap: nowrap;
  width: 350px;
  height: 40px;
}

.vue-date-picker-calendar .calendar-nav-wrapper {
  overflow: hidden;
}

.vue-date-picker-calendar .calendar-nav {
  all: unset;
  cursor: pointer;
  color: #b585ff;

  -webkit-transform: scale(1, 1.6);
  -moz-transform: scale(1, 1.6);
  -o-transform: scale(1, 1.6);
  transform: scale(1, 1.6);

  padding-bottom: 1.2px;
}

.vue-date-picker-calendar .calendar-nav:hover {
  color: white;
}

.vue-date-picker-calendar .year,
.month {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  gap: 10px;

  box-sizing: border-box;
  font-size: 20px;
}

.vue-date-picker-calendar .week {
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: space-around;

  box-sizing: border-box;
  width: 100%;
  height: 50px;

  color: #7548ff;
  font-weight: 700;
  font-size: 18px;
}

.vue-date-picker-calendar .days {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  align-items: center;
  justify-content: flex-start;
  box-sizing: border-box;
  width: 360px;
}

.vue-date-picker-calendar .week > div,
.day {
  display: flex;
  align-items: center;
  justify-content: center;

  box-sizing: border-box;
  width: 50px;
  height: 50px;
}

.vue-date-picker-calendar .day.disallow {
  cursor: not-allowed;
}
.vue-date-picker-calendar .day.disallow span:nth-child(1) {
  position: absolute;
}
.vue-date-picker-calendar .day.disallow span:nth-child(2) {
  width: 100%;
  height: 100%;
  opacity: 0.3;
  background-image: url("/vue/custom\ component/ban.svg");
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  background-size: 70%;
}

.vue-date-picker-calendar .day.in-month {
}

.vue-date-picker-calendar .day.not-in-month {
  color: #cccccc;
}

.vue-date-picker-calendar .day.allow:hover {
  cursor: pointer;
  border-bottom: 1px solid #7548ff;
  overflow: hidden;
}

.vue-date-picker-calendar .is-today {
  border-bottom: 3px solid #7548ff !important;
}

.vue-date-picker-calendar .is-today:hover {
  cursor: pointer;
  background: white;
  color: black;
  overflow: hidden;
  border-radius: 0;
}

.vue-date-picker-calendar .is-selected-day {
  background-color: rgba(117, 72, 255, 0.6);
  color: black;
  border-radius: 7px;
}

.vue-date-picker-calendar .is-selected-day:hover {
  border-radius: 0;
  border-top: unset;
  border-left: unset;
  border-right: unset;
}

.vue-date-picker-calendar .tool-bar {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
  align-items: flex-start;
  margin-left: 10px;

  z-index: 99;
}

.vue-date-picker-calendar .tool-bar > button {
  border: 1px solid #747474;
  border-radius: 6px;
  box-shadow: 10px 10px 20px #e4e4e4;
  background: white;
  padding: 5px 15px;
  font-size: 16px;

  overflow: hidden;
}

.vue-date-picker-calendar .tool-bar > button:hover {
  cursor: pointer;
  background: #000000;
  color: white;
  overflow: hidden;
}

.vue-date-picker-calendar .wrapper-overlay {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  /*background: rgba(0, 0, 50, 50%); // debug 用*/
  z-index: 98;
}
```