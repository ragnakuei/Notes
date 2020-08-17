# FileExtension

```csharp
public class SingleImageFileFormDto
{
    [Required]
    [DataType(DataType.Upload)]
    [FileSize(1, 10, ErrorMessage = "檔案容量要介於 {1} 及 {2} 之間")]
    [FileExtension(new []{"jpg", "jpeg"}, ErrorMessage = "檔案格式有誤")]
    public IFormFile UploadFile { get; set; }
}
```

```csharp
public class FileExtensionAttribute : ValidationAttribute
{
    private readonly string[] _fileExtensions;

    /// <summary>
    /// fileExtensions 清單不用加 .
    /// </summary>
    public FileExtensionAttribute(string[] fileExtensions)
    {
        _fileExtensions = fileExtensions;
    }

    protected override ValidationResult IsValid(object value, ValidationContext validationContext)
    {
        var file = value as IFormFile;
        if (file == null)
        {
            return new ValidationResult("上傳內容有誤");
        }

        var fileExtension = file.FileName.Split('.').LastOrDefault();
        if (_fileExtensions.Any( ext => fileExtension.Equals(ext, StringComparison.OrdinalIgnoreCase)) == false)
        {
            return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
        }

        return ValidationResult.Success;
    }
}
```
