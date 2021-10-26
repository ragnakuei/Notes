# mixin

## \@mixix name

-   將 style 包裝起來，方便達到重用 !

##### 範例

以 @include 來重用

sass

```sass
@mixin function1
  margin: 0

.a
    @include function1()


.b
    @include function1()
```

css

```css
.a {
    margin: 0;
}

.b {
    margin: 0;
}
```

## \@mixin name(parameter)

- name 為 function name 的意思
- 傳入參數，要以 `$` 開頭，參數可加預設值
- 呼叫 function 的方式是以 `+` 開頭再給定 function name

##### 範例

- \$h 後方的 `: $h` 是指預設值

```sass
@mixin size($w, $h : $w)
    width: $w
    height: $h

.calendar
    +size(100%, 100%)
```

