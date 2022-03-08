# scrollbar 加上 border radius

需要二層的 div 

- 外層 div 給定 
  - border-radius
  - width
  - overflow : hidden
- 內層 div 給定
  - height
  - overflow


```html
<style>
    .items {
        width: calc(100% - 20px);
        position: absolute;
        border: 1px solid #747474;
        border-radius: 8px;

        z-index: 99;
        box-shadow: 10px 10px 20px #e4e4e4;

        top: 10px;
        left: 10px;

        overflow: hidden;
    }
    
    .items-scroll {
        height: 200px;
        overflow-x: hidden;
        overflow-y: scroll;
    }
    
    .item {
        width: 100%;
        padding: 5px;
        cursor: pointer;
        background-color: #fff;
        border-bottom: 1px solid #d4d4d4;
    }
    
    .item:hover {
        background-color: #767676;
        color: #ffffff;
    }
</style>
<div class="items">
    <div class="items-scroll">
        <div class="item">Item01</div>
        <div class="item">Item02</div>
        <div class="item">Item03</div>
        <div class="item">Item04</div>
        <div class="item">Item05</div>
        <div class="item">Item06</div>
        <div class="item">Item07</div>
        <div class="item">Item08</div>
        <div class="item">Item09</div>
        <div class="item">Item10</div>
    </div>
</div>
```