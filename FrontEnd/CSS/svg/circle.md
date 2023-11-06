# circle

### 周長 50% 

計算方式：

半徑 r = 20
周長 = 2 * Math.PI * r = 2 * 3.1415926 * 20 = 125.663706
周長 50% = 125.663706 * 50% = 62.831853


```html
<style>
  .half-circle {
    fill: none;
    stroke: blue;
    stroke-width: 4;
    stroke-dasharray: 62.83 62.83; /* 50% of the circumference */
  }
</style>

<svg width="50" height="50">
  <circle class="half-circle" cx="25" cy="25" r="20" />
</svg>
```


### 周長 三分之一

#### 情境一

計算方式：

半徑 r = 20
周長 = 2 * Math.PI * r = 2 * 3.1415926 * 20 = 125.663706
周長 三分之一 = 125.663706 * 33.333333% = 41.887902
周長 三分之二 = 125.663706 * 66.666666% = 83.775804

```html
<style>
  .third-circle {
    fill: none;
    stroke: blue;
    stroke-width: 4;
    stroke-dasharray: 41.89 83.78; 
  }
</style>

<svg width="50" height="50">
  <circle class="third-circle" cx="25" cy="25" r="20" />
</svg>


#### 情境二

計算方式：

半徑 r = 8
周長 = 2 * Math.PI * r = 2 * 3.1415926 * 8 = 50.265482
周長 三分之一 = 50.265482 * 33.333333% = 16.755161
周長 三分之二 = 50.265482 * 66.666666% = 33.510322
