# 呼叫最外層頁面 Function


topPage.html

```html
<html xmlns="http://www.w3.org/1999/xhtml"
      lang="zh-Hant-TW">
<head>
    <title></title>
    <meta http-equiv="Content-Type"
          content="text/html; charset=utf-8" />
</head>

<p>Top Page</p>

<!-- 嵌入子頁面至 iframe 中 -->
<iframe src="/childPage.html"></iframe>

<div>
    Result:
    <input type="text"
           id="result" />
</div>

<script>
    function SetResult(content) {
        document.getElementById('result').value = content;
    }
</script>
</html>

```

childPage.html

```html
<html xmlns="http://www.w3.org/1999/xhtml"
      lang="zh-Hant-TW">
<head>
    <title></title>
    <meta http-equiv="Content-Type"
          content="text/html; charset=utf-8" />
</head>

<p>Child Page</p>

<input type="button"
       id="changeTopPageBtn"
       value="更改 Top Page 資料" />

<script>
    const btnDom = document.getElementById('changeTopPageBtn');
    btnDom.addEventListener('click', function () {
        // 呼叫最外層頁面 Function
        top.SetResult('From Child');
    })
</script>
</html>

```
