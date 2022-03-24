# calendar obj


```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.10.8/dayjs.min.js" integrity="sha512-bwD3VD/j6ypSSnyjuaURidZksoVx3L1RPvTkleC48SbHCZsemT3VKMD39KknPnH728LLXVMTisESIBOAb5/W0Q==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
    function getCalendarByDayjs(givenCurrentDate) {
        const currentDate = dayjs(givenCurrentDate);
        
        const firstDayOfMonth = currentDate.startOf('month');
        const lastDayOfMonth = currentDate.endOf('month');
        
        const weeks = Math.ceil(currentDate.daysInMonth() / 7);
        const calenderTotalDays = weeks * 7;
        
        const firstDayOfCalendar = firstDayOfMonth.subtract(firstDayOfMonth.day(), 'day');
        const lastDayOfCalendar = firstDayOfCalendar.add(weeks * 7 - 1, 'day');
        
        const calendarDays = Array.from(
            { length: calenderTotalDays }, 
            (_, i) => {
                return firstDayOfCalendar.add(i, 'day');
            }
        );
        
        return {
            currentDate,
            firstDayOfMonth,
            lastDayOfMonth,
            weeks,
            calenderTotalDays,
            firstDayOfCalendar,
            lastDayOfCalendar,
            calendarDays,
        }
    }
    const calendarObj = getCalendarByDayjs(new Date());
    console.log('currentDate', calendarObj.currentDate.format('YYYY/MM/DD HH:mm:ss'));
    console.log('firstDayOfMonth', calendarObj.firstDayOfMonth.format('YYYY/MM/DD HH:mm:ss'));
    console.log('lastDayOfMonth', calendarObj.lastDayOfMonth.format('YYYY/MM/DD HH:mm:ss'));
    console.log('weeks', calendarObj.weeks);
    console.log('calenderTotalDays', calendarObj.calenderTotalDays);
    console.log('firstDayOfCalendar', calendarObj.firstDayOfCalendar.format('YYYY/MM/DD HH:mm:ss'));
    console.log('lastDayOfCalendar', calendarObj.lastDayOfCalendar.format('YYYY/MM/DD HH:mm:ss'));
    console.log('calendarDays', calendarObj.calendarDays);
</script>
```