# 利用 html5 submit form 的檢查機制，但不會實際 submit

```html
<!DOCTYPE html>
<html>
    <body>
        <form id="f">
            <label for="quantity">Quantity (between 1 and 5):</label>
            <input type="number" id="quantity" name="quantity" />
            <input type="submit" value="submit" />
        </form>
    </body>
    <script>
        window.addEventListener('load', function (event) {
            const form = document.getElementById('f');
            form.addEventListener('submit', function (e) {
                e.preventDefault();
                return false;
            });
        });
    </script>
</html>
```
