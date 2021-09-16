# mixin

## \@mixix name

-   將 style 包裝起來，方便達到重用 !

##### 範例一

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

-   可傳入參數，參數要以 `$` 開頭

##### 範例二
