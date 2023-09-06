# animation

[mdn](https://developer.mozilla.org/en-US/docs/Web/CSS/animation)

## format

```css
/*         @keyframes duration | easing-function | delay | iteration-count | direction | fill-mode | play-state | name */
animation: 3s                    ease-in           1s      2                 reverse     both        paused       slidein;

/*         @keyframes name | duration | [easing-function] | [delay] */
animation: slidein           3s         linear            1s;
```


注意事項：

- [keyframe 不能套用 display](https://stackoverflow.com/questions/26607330/css-display-none-and-opacity-animation-with-keyframes-not-working)