# IFormFileCollection 與 IFormFile[] 差異

### IFormFile[]

```html
<form method="post" 
      enctype="multipart/form-data" 
      asp-page-handler="Update">

    <input type="file" 
           multiple 
           name="uploadFiles" />

    <input type="submit" value="Submit" />
</form>
```

```cs
public class Dto
{
    public IFormFile[]? uploadFiles { get; set; }
    
    // 下面這種也可以 !
    // public IFormFileCollection? uploadFiles { get; set; }
}
```
