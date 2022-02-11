# Embedded


### referrer-policy

web.config 加上下面這行後，youtube iframe 就無法播放影片了 !

```xml
<add name="Referrer-Policy" value="no-referrer"/>
```

相關資料：

- https://stackoverflow.com/questions/51424578/embed-youtube-code-is-not-working-in-html


解決方式：

> 如果全域要加上對應的 `Referrer-Policy>` 那唯一的解法就是在 iframe 加上 referrer-policy

完整的語法

- 注意 `referrerpolicy='no-referrer'`

```html
<iframe width='560' 
        height='315' 
        src='https://www.youtube.com/embed/{0}' 
        frameborder='0' 
        allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' 
        allowfullscreen 
        referrerpolicy='no-referrer'>
</iframe>
```