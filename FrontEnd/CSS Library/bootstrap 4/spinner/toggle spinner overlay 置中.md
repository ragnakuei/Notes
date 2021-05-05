# toggle spinner overlay 置中

- 一開始要先把 overlay 改用 display flex 並隱藏
- 之後就可以套用 fadeIn() / fadeOut()

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<style>
  #overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    text-align: center;
    background: rgba(0, 0, 0, 0.2);
    
    display: none;
    flex-direction: row;
    flex-wrap: wrap;
  }

  #overlay div {
    position: relative;
    margin: auto;
  }
</style>

<button onclick="ShowSpinner()">Show Spinner</button>

<div id="overlay">
  <div class="spinner-border" role="status">
    <span class="sr-only">Loading...</span>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script>
  const dom = $("#overlay");
  dom.css("display", "flex").hide();

  function ShowSpinner() {
      
    console.log("Spinner fdadeIn");
    dom.fadeIn(300);
    
    setTimeout(function() {
        
      console.log("Spinner fadeOut");
      dom.fadeOut(300);

    }, 1000);
  }
</script>
```