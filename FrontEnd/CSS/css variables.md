# [css variables](https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties)


別人分享的構思

- 在 css 定義好 變數
- 再透過 js 來動態給定，可以達到快速切換 theme 的效果

```js
document.documentElement.style.setProperty(`--select-${t}` , `var(--${themename}-${t})`)
```