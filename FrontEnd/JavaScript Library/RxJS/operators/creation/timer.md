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

    timer(2000, 500)
    .subscribe({
          next: (val) => console.log(val),
          complete: () => console.log('complete'),
          error: val => console.log('error', val)
        });
    ```
