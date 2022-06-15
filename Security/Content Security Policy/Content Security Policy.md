# Content Security Policy

-   [Content Security Policy (CSP)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
-   [Content Security Policy (CSP) 筆記](https://hackmd.io/@Eotones/BkOX6u5kX)
-   [網頁內容安全政策 (Content Security Policy)](https://blog.johnwu.cc/article/ironman-day27-asp-net-core-content-security-policy.html)
-   不同項目的 `scheme-source` 會不一樣

## nonce

TODO: Asp.Net Core 做法待釐清

### 語法

```
Content-Security-Policy: script-src 'nonce-2726c7f26c'
```

```html
<script nonce="2726c7f26c">
    // ...
</script>
```

## [script-src](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/script-src)

### unsafe-inline

會影響是否能使用 inline script !

## [img-src](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy/img-src)

### 允許使用 base64

在 img-src 後面加上 `'self' data:` !

```
content-security-policy: img-src 'self' data: ;
```
