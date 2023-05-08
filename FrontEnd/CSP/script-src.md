# script-src

註：如果搭配 live server 測試，要記得會被加上一段 script tag 而無法被成功執行，所以要確實注意不能被執行的 script 是哪一段

### 格式

Content-Security-Policy: script-src 'nonce-2726c7f26c' 'strict-dynamic' https: http: 'unsafe-inline' 'unsafe-eval' 'self' 'report-sample' https://www.google-analytics.com/analytics.js



指定 sha

Content-Security-Policy: script-src 'sha256-B2yPHKaXnvFWtRChIbabYmUBFZdVfKKXHbWtWidDVF8=' 'strict-dynamic' https: http: 'unsafe-inline' 'unsafe-eval' 'self' 'report-sample' https://www.google-analytics.com/analytics.js

- 後面無法再套用 'unsafe-inline' 'unsafe-eval' 'self' 'report-sample' 之類的設定

### nonce 範例

- 唯一可套用 inline script 的方式

```html
<html lang="en">

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Inline Script Example</title>
    <meta http-equiv="Content-Security-Policy"
          content="script-src 'nonce-123abc' ;">
</head>

<body>
    <input onclick="test()"
           type="button"
           value="Click me">


    <script nonce="123abc">
        function test() {
            alert('Hello, world!');
        }
    </script>

</body>

</html>
```


### sha256 範例

- 只能用於引用外部 script 檔案
- 產生 sha 最簡單的方式
  - 先隨便給定 hash 值
  - 執行該網頁
  - 查看 console 錯誤訊息，該訊息會提供正確的 hash 值

```html
<html lang="en">

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Inline Script Example</title>
    <meta http-equiv="Content-Security-Policy"
          content="script-src 'sha256-cSp4XPF0WquktkIK+pAumREKE7w9CLJfX1Hj0N5q3Ls=' ;">
</head>

<body>
    <input id="btn"
           type="button"
           value="Click me">

    <script src="/csp/example01.js" integrity="sha256-cSp4XPF0WquktkIK+pAumREKE7w9CLJfX1Hj0N5q3Ls="></script>

</body>

</html>
```