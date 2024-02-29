# command

通常包含以下幾個部份：

-   Command
-   Concrete Command
-   Receiver
-   Invoker
-   Client

### 範例 1

-   Command

    -   Task
    -   AddTask
    -   RemoveTask
    -   DelayTask

-   Concrete Command

    -   AddTask
    -   RemoveTask
    -   DelayTask

-   Receiver

    -   TaskManager > tasks

-   Invoker

    -   TaskManager

-   Client
    -   new TaskManager() 之後的操作

```js
class TaskManager {
    constructor() {
        this.tasks = [];
    }

    // 統一執行介面
    execute(task, ...args) {
        // 這邊的 execute 是 Task 的 execute
        return task.execute(this.tasks, ...args);
    }
}

class Task {
    constructor(execute) {
        // 各類別實作自己的執行邏輯
        this.execute = execute;
    }
}

class AddTask extends Task {
    constructor(task) {
        super((tasks) => {
            const id = new Date().getTime();
            tasks.push({ id, task });
            return id;
        });
    }
}

class RemoveTask extends Task {
    constructor() {
        super((tasks, id) => {
            const index = tasks.findIndex((task) => task.id === id);
            if (index !== -1) {
                tasks.splice(index, 1);

                console.log('remove', id);

                return true;
            }
            return false;
        });
    }
}

class DelayTask extends Task {
    constructor() {
        super((tasks, task, delay) => {
            return new Promise((resolve) => {
                setTimeout(() => {
                    const id = new Date().getTime();
                    tasks.push({ id, task });
                    resolve(id);
                }, delay);
            });
        });
    }
}

const manager = new TaskManager();
const id1 = manager.execute(new AddTask('Task 1'));
console.log('id1', id1);

manager.execute(new DelayTask('Task 2', 1000)).then((id2) => {
    console.log('id2', id2);

    manager.execute(new RemoveTask(), id2);
});

manager.execute(new RemoveTask(), id1);
```


### 範例 2

這個 Pattern 其實也有 Publish-Subscribe Pattern 的操作 !

```js
// Receiver classes
class Light {
    on() {
        console.log("Light is on");
    }
    off() {
        console.log("Light is off");
    }
}

class Fan {
    start() {
        console.log("Fan is started");
    }
    stop() {
        console.log("Fan is stopped");
    }
}

// Command interface and concrete command classes
class Command {
    execute() {}
}

class LightOnCommand extends Command {
    constructor(light) {
        super();
        this.light = light;
    }
    execute() {
        this.light.on();
    }
}

class LightOffCommand extends Command {
    constructor(light) {
        super();
        this.light = light;
    }
    execute() {
        this.light.off();
    }
}

class FanStartCommand extends Command {
    constructor(fan) {
        super();
        this.fan = fan;
    }
    execute() {
        this.fan.start();
    }
}

class FanStopCommand extends Command {
    constructor(fan) {
        super();
        this.fan = fan;
    }
    execute() {
        this.fan.stop();
    }
}

// Invoker class
class RemoteControl {
    constructor() {
        this.commands = [];
    }
    addCommand(command) {
        this.commands.push(command);
    }
    executeCommands() {
        for (let command of this.commands) {
            command.execute();
        }
    }
}

// Client code
let light = new Light();
let fan = new Fan();

let lightOnCommand = new LightOnCommand(light);
let lightOffCommand = new LightOffCommand(light);
let fanStartCommand = new FanStartCommand(fan);
let fanStopCommand = new FanStopCommand(fan);

let remoteControl = new RemoteControl();
remoteControl.addCommand(lightOnCommand);
remoteControl.addCommand(fanStartCommand);
remoteControl.executeCommands();

remoteControl = new RemoteControl();
remoteControl.addCommand(lightOffCommand);
remoteControl.addCommand(fanStopCommand);
remoteControl.executeCommands();
```