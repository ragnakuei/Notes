# 利用 html5 submit form 的檢查機制，但不會實際 submit

```html
<!DOCTYPE html>
<html>
    <body>
        <form id="f">
            <label for="quantity">Quantity:</label>
            <input type="number" />
            <input type="submit" value="submit" />
        </form>
        <script>
            window.addEventListener('load', function (event) {
                $('#f').submit(function (e) {
                    e.preventDefault();
                    return false;
                });
            });
        </script>
    </body>
</html>
```
