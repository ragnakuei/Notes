# ajax 上傳檔案 範例 01

- ajax 不需要 form tag 的 enctype="multipart/form-data"
- multiple - 加了則為多檔 !
- 注意：FormData 的 Property Name 不用給定索引 !

```cs
@page
@{
    Layout = null;
}

<form>

    <input type="file"
           multiple
           name="uploadFiles" />

    <input type="button"
           onclick="Post()"
           value="Submit" />
</form>

<script src="~/lib/jquery/dist/jquery.min.js"></script>
<script>
    function Post() {
        const form_data = new FormData();

        for (const file of $('input[name="uploadFiles"]').prop('files')) {
            form_data.append('files', file);
        }
        
        // 純 js 語法
        // const input = document.getElementsByName('uploadFiles')[0];
        // const files = input.files;
        //
        // for (let i = 0; i < files.length; i++) {
        //   form_data.append("files", files[i]);
        // }
        
       $.ajax({
            type: "POST",
            url: "?handler=Update",
            data: form_data,
            processData: false,
            contentType: false,
            beforeSend: function(xhr){
                xhr.setRequestHeader('RequestVerificationToken', $('input:hidden[name="__RequestVerificationToken"]').val());
            },
            success: function (data) {
                alert('ok');
            }
        });
    }
</script>

@functions
{
    public void OnGet()
    {
    }

    public IActionResult OnPostUpdate([FromForm]IList<IFormFile> files)
    {
        return new OkResult();
    }
}
```