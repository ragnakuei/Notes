# ajax 上傳檔案 範例 01

- ajax 不需要 form tag 的 enctype="multipart/form-data"
- 注意：FormData 的 Property Name 不用給定索引 !

### 單純的 IEnumerable\<IFormFile>

```cs
@page
@{
    Layout = null;
}

<form>

    <input type="file"
           name="uploadFiles1" />
    
    <input type="file"
           name="uploadFiles2" />

    <input type="button"
           onclick="Post()"
           value="Submit" />
</form>

<script src="~/lib/jquery/dist/jquery.min.js"></script>
<script>
    function Post() {
        const form_data = new FormData();
        
        form_data.append('files', $('input[name="uploadFiles1"]').prop('files')[0]);
        form_data.append('files', $('input[name="uploadFiles2"]').prop('files')[0]);
        
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

### IEnumerable\<IFormFile> 為 Model 的 Property Type

- 跟上面的範例相比，雖然多了一層 Model，但仍不需要給定 dto 這個 Property Name，但是再往內一層，就要加了 !

```cs
@page
@{
    Layout = null;
}

<form method="post"
      enctype="multipart/form-data"
      asp-page-handler="Update">

    <input type="file"
           name="uploadFiles1" />
    
    <input type="file"
           name="uploadFiles2" />

    <input type="button"
           onclick="Post()"
           value="Submit" />
</form>

<script src="~/lib/jquery/dist/jquery.min.js"></script>
<script>
    function Post() {
        const form_data = new FormData();
    
        // TODO:
        // 1. 多檔
        // 2. nested property name 
        
        form_data.append('files', $('input[name="uploadFiles1"]').prop('files')[0]);
        form_data.append('files', $('input[name="uploadFiles2"]').prop('files')[0]);
        
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

    public IActionResult OnPostUpdate([FromForm] Dto dto)
    {
        return new OkResult();
    }

    public class Dto
    {
        public IList<IFormFile> files { get; set; }
    }
}
```