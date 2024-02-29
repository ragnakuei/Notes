# CSP 過不了

```html

<!DOCTYPE html>
<html lang="en" >
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta http-equiv="Content-Security-Policy" content="default-src 'self' ; style-src 'self' ; script-src https://unpkg.com/petite-vue 'unsafe-inline' 'unsafe-eval' 'self' ; ">
    <title>title - Local Live Server</title>
</head>
<body>

    <script src="https://unpkg.com/petite-vue" defer init></script>

<div v-scope="{ count: 0 }">
  {{ count }}
  <button @click="count++">inc</button>
</div>

</body>
</html>
```