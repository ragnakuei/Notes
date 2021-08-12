# abort request

呼叫 $.ajax().abort() 後，確實可以在 Chrome > Newtork 看出被 cancel 的 request !

- 如果後端是 asp.net core 的話，甚至可以看到 CancellationToken.IsCancellationRequested 變成 true !

```html
<button id="btn" onclick="OnButtonClick()" >Click</button>

<script src="~/lib/jquery/dist/jquery.min.js"></script>

<script>
    let isRequesting = false;
    let xhr = null;

    function OnButtonClick() {
        if (isRequesting)
        {
            xhr.abort();
            isRequesting = false;
        }
        else
        {
            xhr = $.ajax({
                            type: "Get",
                            url: "/test",
                            success: function(msg){

                            }
                        });
            isRequesting = true;
        }
    }

</script>
```