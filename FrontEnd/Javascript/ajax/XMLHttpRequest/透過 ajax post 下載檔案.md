# 透過 ajax post 下載檔案

## 範例

以下範例搭配[_CustomRequest](../../JavaScript%20Library/jQuery/CustomRequest.md)

jQuery 版:


```js
self.PostDownloadFile = function()
{
    try
    {
        $.ajax( {
            type: 'POST',
            url: url,
            data: JSON.stringify( requestBody ),
            contentType: 'application/json',
            beforeSend: function( xhr ) {
                xhr.setRequestHeader( 'RequestVerificationToken', $( 'input:hidden[name="__RequestVerificationToken"]' ).val() );
            },
            xhrFields: {
                responseType: 'blob'
            },
        } ).done( function( blob, status, xhr ) {
            
            let filename = "";
            const disposition = xhr.getResponseHeader('Content-Disposition');
            if (disposition && disposition.indexOf('attachment') !== -1) {
                const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                const matches = filenameRegex.exec(disposition);
                if (matches != null && matches[1])
                {
                    filename = matches[1].replace(/['"]/g, '');
                    filename = filename.replace(/\+/g, '%20')
                    filename = decodeURI(filename.replace('UTF-8',''));
                }
            }

            const link=document.createElement('a');
            link.href=window.URL.createObjectURL(blob);
            link.download=filename;
            link.click();
            
        }).fail( function( jqXHR, textStatus ) {
            console.log( "Request failed: " );
            console.log( textStatus );

            if( jqXHR?.responseText ) {
                alert( jqXHR.responseText );
            }
        } );
    }
    catch (e)
    {
        alert('發生錯誤，請聯絡開發人員 !');
        console.log(e);
    }
}
```
XMLHttpRequest 版:


```js
self.PostDownloadFile = function()
{
    try
    {
        const req = new XMLHttpRequest();

        // 指定 Http Method 及 Url 及 是否使用 async
        req.open("POST", self.Option.Url, true);

        // 套用 asp.net core 需要的 CSRF Antiforgery Token
        req.setRequestHeader("@(ViewParameter.RequestVerificationToken)", Antiforgery.@(ViewParameter.RequestVerificationToken));
        req.responseType = "blob";

        req.onload = function (event) 
        {
            const blob = req.response;
            console.log(blob);

            // 解析 file name
            let filename = "defaultFile";
            const disposition = req.getResponseHeader('Content-Disposition');
            if (disposition && disposition.indexOf('attachment') !== -1) 
            {
                const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                const matches = filenameRegex.exec(disposition);
                if (matches != null && matches[1]) {
                    filename = matches[1].replace(/['"]/g, '');
                    filename = filename.replace(/\+/g, '%20')
                    filename = decodeURI(filename.replace('UTF-8',''));
                }
            }

            const link=document.createElement('a');
            link.href=window.URL.createObjectURL(blob);
            link.download=filename;
            link.click();
        };

        // request body 放在這
        req.send(self.Option.RequestBody);
    }
    catch (e)
    {
        alert('發生錯誤，請聯絡開發人員 !');
        console.log(e);
    }
}
```

fetch 版：

```js
function fetch_json_download( url, requestBody ) {
    return fetch( url, {
        method: 'POST',
        body: JSON.stringify( requestBody ),
        headers: {
            'Content-Type': 'application/json',
            'RequestVerificationToken': $( 'input:hidden[name="__RequestVerificationToken"]' ).val()
        },
        credentials: 'same-origin'
    } ).then( response => {
        if( !response.ok ) {
            response.json().then( json => {
                process_fetch_error_response( json );
            } )
        }
        return response.blob()
            .then( blob => {
                let filename = "";
                const disposition = response.headers.get( 'Content-Disposition' );
                if( disposition && disposition.indexOf( 'attachment' ) !== -1 ) {
                    const filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                    const matches = filenameRegex.exec( disposition );
                    if( matches != null && matches[1] ) {
                        filename = matches[1].replace( /['"]/g, '' );
                        filename = filename.replace( /\+/g, '%20' )
                        filename = decodeURI( filename.replace( 'UTF-8', '' ) );
                    }
                }
                const link = document.createElement( 'a' );
                link.href = window.URL.createObjectURL( blob );
                link.download = filename;
                link.click();
            } ).catch( error => {
                process_error_response( error );
            } );
    } )
}
```