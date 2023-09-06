# 關閉 tab 時，執行額外的動作

這不是正常做法，正常做法要搭配 websocket 去達成 !

先決條件

1. 原本的頁面必須經過觸發與使用者互動

    當使用者進入下面的頁面後，按下 Close 按鈕，再關閉 tab 時，就有機會 (但不保証) 觸發 window.onbeforeunload 事件，也可以觸發 setTimeout 裡面的 window.open()


    ```html
    <html lang="en">
    <head>
        <meta charset="utf-8" />
    </head>

    <body>
        <button
        type="button"
        id="btnClose"
        >
        Close
        </button>

        <script>
        window.onbeforeunload = function () {
            setTimeout(() => {
                // 這裡的 window.open 有機會被瀏覽器觸發
                window.open("close.html");
            }, 0);

            // 無法自訂訊息，這個訊息會被瀏覽器忽略
            return "確定要離開嗎？";
        };
        </script>
    </body>
    </html>
    ```

close.html

- 要執行額外的動作，就必須在這個頁面裡面執行

```html
<html lang="en">
  <head>
    <meta charset="utf-8" />
  </head>

  <body>
    <div id="msg"></div>

    <script>

      window.onload = function () {
        document.getElementById("msg").innerHTML = "正在處理關閉事件...";

        setTimeout(() => {
          window.close();
        }, 3000);
      };

    </script>
  </body>
</html>
```