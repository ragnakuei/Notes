# [he](https://github.com/mathiasbynens/he)

對 javascript 的 value 做 html encode / decode

```js
const html_string = "&#x3C;script&#x3E;alert(&#x22;&#x6703;&#x88AB;xss&#x22;)&#x3C;/script&#x3E;"
const html_decode = he.decode(html_string);    // decode 後 => <script>alert('會被xss')</script>
const html_decode_encode = he.encode(html_decode);
console.log('html_decode', html_decode);
console.log('html_decode_encode', html_decode_encode);
```

