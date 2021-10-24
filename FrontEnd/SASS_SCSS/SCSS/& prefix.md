# & prefix

###

以下二個是一樣的意思

scss

```scss
.some-class {
  &.another-class {}
}
```

css

```css
.some-class.another-class { }
```

###

scss

```scss
.some-class {
    font-size: 20px;

    &.another-class {
        font-size: 12px
    }
}
```
css


```css
.some-class {
  font-size: 20px;
}
.some-class.another-class {
  font-size: 12px;
}
```