# summernote

[官網](https://summernote.org/)

- 須搭配
  - jQuery
  - Bootstrp

## 範例

### 搭配上傳圖片 API

- 也支援拖曳圖片進編輯區

[範例連結](https://github.com/ragnakuei/SummernoteTest)

```html
@model ViewModel
@{
}

<form method="post">
    <textarea id="summernote" asp-for="HtmlEditorContent"></textarea>
    <input type="submit" value="送出" />
</form>

@section Scripts
{
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>

    @* bootstrp 3 *@
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

    @* bootstrap 4 *@
    @* <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script> *@
    @* <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous"> *@
    @* <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script> *@
    @* <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet"> *@
    @* <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script> *@

    @* 套用語系需要的 *@
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-zh-TW.min.js"></script>

    <script>
        $(document).ready(function() {
            $('#summernote').summernote({
                lang: 'zh-TW',   // 指定語系
                callbacks: {
                    // override 原本上傳圖片的動作
                    onImageUpload: function(files) {
                        for(let i = files.length - 1; i >= 0; i--) {
                            ajaxPostFile(files[i], InsertImageToSummernote);
                        }
                    }
                },
            });
        });

        // 透過 ajax 上傳圖片, api 回傳圖片 url
        function ajaxPostFile(file, successCallback) {
            const form_data = new FormData();
            form_data.append('uploadFile', file);
            $.ajax({
                    data: form_data,
                    type: "POST",
                    url: '@Url.Action("Image", "Upload")',
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: successCallback,
           });
        }

        // 將 url 放進 summernote 中
        function InsertImageToSummernote(url) {
            $('#summernote').summernote('editor.insertImage', url);
        }

    </script>
}
```

上傳圖片 API
- 上傳至 網站根目錄/Upload/Images

```csharp
public class UploadController : Controller
{
    private readonly FileService _fileService;

    public UploadController(FileService fileService)
    {
        _fileService = fileService;
    }

    [HttpPost]
    public async Task<IActionResult> Image(IFormFile uploadFile)
    {
        var newFileName = await _fileService.SaveImageAsync(uploadFile);

        var imageUrl = Url.Action("Image", "File", new { fileName = newFileName });

        return Ok(imageUrl);
    }
}

public class FileService
{
    static FileService()
    {
        TryCreateFolder(_imageFolder);
    }

    private static readonly string _imageFolder = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Upload", "Images");

    private static void TryCreateFolder(string newFileFolder)
    {
        if (Directory.Exists(newFileFolder))
        {
            return;
        }

        Directory.CreateDirectory(newFileFolder);
    }

    public async Task<string> SaveImageAsync(IFormFile fileDto)
    {
        var newFileName = Guid.NewGuid().ToString() + new FileInfo(fileDto.FileName).Extension;

        var filePath = Path.Combine(_imageFolder, newFileName);

        using (var fileStream = new FileStream(filePath, FileMode.Create))
        {
            await fileDto.CopyToAsync(fileStream);
        }

        return newFileName;
    }

    public FormFileDto GetImage(string fileName)
    {
        return new FormFileDto
               {
                   FileName    = fileName,
                   FilePath    = Path.Combine(_imageFolder, fileName),
                   ContentType = GetContentType(fileName)
               };
    }

    private static string GetContentType(string fileName)
    {
        var provider = new FileExtensionContentTypeProvider();
        provider.TryGetContentType(fileName, out var contentType);
        return contentType;
    }
}
```
