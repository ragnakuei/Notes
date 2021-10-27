# [delay](https://rxjs.dev/api/operators/delay)

先 delay 後輸出

#### 範例

- 固定間隔 delay

    ```html
    <div id="message"></div>

    <script src="https://unpkg.com/rxjs@^7/dist/bundles/rxjs.umd.min.js"></script>
    <script>
        const { range, of, from } = rxjs;
        const { map,concatMap, filter, repeat, delay } = rxjs.operators;

        const messageDom = document.getElementById('message');
        
        of("Get Ready !", 3, 2, 1, "Go !")
            .pipe(
                concatMap(x => of(x).pipe(delay(1000))),
            )
            .subscribe((x) => messageDom.innerHTML = x);
    </script>
    ```

- 動態給定間隔

    ```html
    <div id="message"></div>
    <button class="footer" onclick="run">ReRun</button>

    <script src="https://unpkg.com/rxjs@^7/dist/bundles/rxjs.umd.min.js"></script>
    <script>
        const { range, of, from, concat, empty, timer } = rxjs;
        const { map,concatMap, filter, repeat, delay, startWith } = rxjs.operators;

        const messageDom = document.getElementById('message');
        
        const showMessageWithDelay = function(message, delayMs = 1000) {
            return of(message).pipe( delay(delayMs) );
        };
        
        const run = function() {
            concat(
                showMessageWithDelay('Get Ready !'),
                showMessageWithDelay('3'),
                showMessageWithDelay('2'),
                showMessageWithDelay('1'),
                showMessageWithDelay('Go !'),
                showMessageWithDelay('', 3000)
            )
            .subscribe(
                (x) => {
                    console.log(x);
                    messageDom.innerHTML = x;
                },
                (err) => console.log(err),
                () => console.log('complete')
            );   
        }
        
        run();
    </script>
    ```
