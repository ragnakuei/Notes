# [milestone](https://docs.dhtmlx.com/gantt/desktop__milestones.html#specifyingmilestonesinadataset)

rollup : boolean

-   只會 rollup 至 project，無法 rollup 至 task，請[參考](https://docs.dhtmlx.com/gantt/desktop__milestones.html#rolluptasksandmilestones)

### 讓 milestone 顯示在 task 上方

[參考資料在下方的回覆中](https://docs.dhtmlx.com/gantt/desktop__milestones.html#rolluptasksandmilestones)

```css
.rollup_milestone {
    position: absolute;
    border-radius: 2px;
    height: 20px;
    width: 20px;
    background: #0000ff;
    top: -6px;
    border: 1px solid #61164f;
    transform: rotate(45deg);
    z-index: 2;
}
```

#### 讓 milestone 顯示在 每層父節點 上方

```js
// 取得指定 task 內的所有 rollup milestones
function getBelowRollupMilestones(taskId) {
    const result = [];
    const childIds = gantt.getChildren(taskId);

    for (const childId of childIds) {
        const task = gantt.getTask(childId);
        if (
            task.type === gantt.config.types.milestone &&
            task.rollup === true
        ) {
            result.push(task);
            continue;
        }

        result.push(...getBelowRollupMilestones(childId));
    }

    return result;
}

function drawRollupedElements(task) {
    // console.log('drawRollupedElements', {
    //   task,
    // });

    const belowRollupMilestones = getBelowRollupMilestones(task.id);
    if (belowRollupMilestones.length === 0) {
        return false;
    }

    // 讓下層節點的 milestone 可以顯示在父節點上 !

    const customRollupedElementRoot = document.createElement('div');

    const taskSizes = gantt.getTaskPosition(
        task,
        task.start_date,
        task.end_date,
    );

    for (const milestone of belowRollupMilestones) {
        const customRollupedElement = document.createElement('div');
        customRollupedElement.className = 'rollup_milestone';

        const childSizes = gantt.getTaskPosition(
            milestone,
            milestone.start_date,
            milestone.end_date,
        );
        customRollupedElement.style.left = childSizes.left - 11 + 'px';

        customRollupedElement.style.top = taskSizes.top + 7 + 'px';

        customRollupedElementRoot.appendChild(customRollupedElement);
    }

    return customRollupedElementRoot;
}

gantt.attachEvent('onGanttReady', function () {
    gantt.addTaskLayer(drawRollupedElements);
});
```

#### 以父節點為出發點的做法

```js
function drawRollupedElements(task) {
    const childTaskIds = gantt.getChildren(task.id);
    if (childTaskIds.length == 0) {
        return false;
    }

    console.log('drawRollupedElements', {
        task,
        childTaskIds,
    });

    const customRollupedElementRoot = document.createElement('div');

    const taskSizes = gantt.getTaskPosition(
        task,
        task.start_date,
        task.end_date,
    );
    const sizes = gantt.getTaskPosition(task, task.start_date, task.end_date);

    for (const childTaskId of childTaskIds) {
        const childTask = gantt.getTask(childTaskId);
        if (
            childTask.type !== gantt.config.types.milestone ||
            childTask.rollup !== true
        ) {
            continue;
        }

        const customRollupedElement = document.createElement('div');
        // 給定 class rollup_milestone
        customRollupedElement.className = 'rollup_milestone';

        const childSizes = gantt.getTaskPosition(
            childTask,
            childTask.start_date,
            childTask.end_date,
        );
        // left 以子節點為基準
        customRollupedElement.style.left = childSizes.left - 11 + 'px';

        // top 以父節點為基準
        customRollupedElement.style.top = sizes.top + 7 + 'px';

        customRollupedElementRoot.appendChild(customRollupedElement);
    }

    if (customRollupedElementRoot.childNodes.length > 0) {
        return customRollupedElementRoot;
    }

    return false;
}
gantt.attachEvent('onGanttReady', function () {
    gantt.addTaskLayer(drawRollupedElements);
});
```

#### 以子節點為出發點的做法

這個做法

-   父節點收合後，就無法顯示子節點的 milestone

```js
function drawRollupedElements(task) {
    console.log('drawRollupedElements', task);
    const customRollupedElementRoot = document.createElement('div');

    if (task.rollup && task.parent != gantt.config.root_id) {
        const parentTask = gantt.getTask(task.parent);
        const parentSizes = gantt.getTaskPosition(
            parentTask,
            parentTask.start_date,
            parentTask.end_date,
        );
        const sizes = gantt.getTaskPosition(
            task,
            task.start_date,
            task.end_date,
        );
        const customRollupedElement = document.createElement('div');

        if (task.type == gantt.config.types.milestone) {
            customRollupedElement.className = 'rollup_milestone';
            customRollupedElement.style.left = sizes.left - 11 + 'px';
            customRollupedElement.style.top = parentSizes.top + 7 + 'px';
        }
        console.log('customRollupedElement', customRollupedElement);
        customRollupedElementRoot.appendChild(customRollupedElement);
    }

    if (customRollupedElementRoot.childNodes.length > 0) {
        return customRollupedElementRoot;
    }

    return false;
}
gantt.attachEvent('onGanttReady', function () {
    gantt.addTaskLayer(drawRollupedElements);
});
```
