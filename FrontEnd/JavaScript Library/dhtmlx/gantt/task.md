# [task](https://docs.dhtmlx.com/gantt/desktop__task_types.html)

### 相關 config

-   gantt.config.cascade_delete = false;

### 相關操作

-   gantt.getTask(taskId);
-   gantt.addTask({});
-   gantt.refreshTask(taskId);
-   gantt.updateTask(taskId);
    -   某些情況下，更新 task 後，會造成 task 顯示不正確，此時可以用 gantt.refreshTask(taskId) 來更新 task
-   gantt.moveTask(fromTaskId, , toTaskId)
-   gantt.refreshData();
-   gantt.getPrevSibling(taskId)
    -   在同一層的 task 中，取得 taskId 的前一個 taskId
-   gantt.getPrevSibling(taskId)
    -   在同一層的 task 中，取得 taskId 的後一個 taskId
-   gantt.isSelectedTask(taskId)
    -   判斷 taskId 是否被選取
-   gantt.eachSelectedTask((taskId) => {})
    -   對每個被選取的 task 做處理
-   gantt.getChildren(taskId)
    -   取得 taskId 的 child taskIds
-   gantt.serialize()
    -   取出完整 gantt 上的 data 及 link

### 新增 child task 後

-   用 gantt.open(taskId) 來展開該 task
-   用 gantt.close(taskId) 來收起該 task

### 刪除 task

-   用 gantt.deleteTask(taskId) 來刪除 task

注意事項：

Q：刪除時，出現 Task not found id: xxxxx 錯誤訊息 !
A: 參考 [解法](https://forum.dhtmlx.com/t/questions-about-gantt-deletetask/71391)

解法 1：

```js
setTimeout(() => {
    gantt.deleteTask(taskId);
}, 0);
```

解法 2：

```js
// 點擊任務時的事件
gantt.attachEvent('onTaskClick', (id, e) => {
    console.log('onTaskClick');
    // 也用來避免 deleteTask 時，會產金額外的錯誤訊息
    return false;
});
```

### 注意事項

task 有 open 的 property，是用來 `在初始化時` 判斷是否展開該 task。
經過 `初始化後`

-   就不能用改變 task property 來控制 task 顯示的相關狀態
-   但仍然可以改變資料欄位
