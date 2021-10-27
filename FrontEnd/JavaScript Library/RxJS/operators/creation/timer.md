# [timer](https://rxjs.dev/api/index/function/timer)

參數

1. delay ms

    ```js
    import { timer } from 'rxjs';

    const source = timer(500);
    const subscribe = source.subscribe((val) => console.log(val));
    ```

2. period ms

    ```js
    import { timer } from 'rxjs';

    const source = timer(2000, 500);
    const subscribe = source.subscribe((val) => console.log(val));
    ```
