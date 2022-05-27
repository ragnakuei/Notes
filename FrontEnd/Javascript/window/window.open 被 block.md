# window.open 被 block

-   [參考資料](https://stackoverflow.com/questions/2587677/avoid-browser-popup-blockers)
-   只要不是透過 user 觸發的，就會被 block

### 範例

-   被 block

    ```html
    <script>
        window.open('https://localhost:7134/test1');
    </script>
    ```

-   不會被 block

    ```html
    <button onclick="window.open('https://localhost:7134/test1');" >Open Test 1</button>
    ```