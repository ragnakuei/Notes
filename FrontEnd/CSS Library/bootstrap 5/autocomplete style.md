# autocomplete style


```html
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<style>
    .container {
        margin-top: 20px;
    }

    #auto-complete {
        position: relative;
    }

    .items {
        width: 100%;
        top: 5px;
        position: absolute;
        border: 1px solid #747474;
        border-radius: 3px;
        z-index: 99;
        box-shadow: 10px 10px 20px #e4e4e4;
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
<div class="container">
    <div class="form-floating">
        <input type="text" id="name" class="form-control" placeholder="x" />
        <label class="col-form-label" for="name">
            AutoComplete Style 範例
        </label>

        <div id="auto-complete" style="display: none;">
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
        </div>
    </div>
</div>

<script>
    const autoComplete = document.getElementById('auto-complete');
    
    const nameDom = document.getElementById('name');
    nameDom.addEventListener('click', (event) => {
        autoComplete.style.display = "block";
    });
    nameDom.addEventListener('blur', (event) => {
        autoComplete.style.display = "none";
    })
    
    
    for(let item of document.getElementsByClassName('item')) {
        item.addEventListener('mouseover', (event) => {
            nameDom.value = event.target.innerHTML;
        });    
    }
    
</script>
```