# FileSize

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
public class FileSizeAttribute : ValidationAttribute
{
    private readonly long _minFileSize;
    private readonly long _maxFileSize;

    public FileSizeAttribute(long minFileSize, long maxFileSize)
    {
        _minFileSize = minFileSize;
        _maxFileSize = maxFileSize;
    }

    protected override ValidationResult IsValid(object value, ValidationContext validationContext)
    {
        var file = value as IFormFile;
        if (file == null)
        {
            return new ValidationResult("上傳內容有誤");
        }

        if (file.Length > _maxFileSize)
        {
            return new ValidationResult(FormatErrorMessage(validationContext.DisplayName));
        }

        return ValidationResult.Success;
    }

    public override string FormatErrorMessage(string name)
    {
        return string.Format((IFormatProvider)CultureInfo.CurrentCulture,
                                this.ErrorMessageString,
                                new object[3]
                                {
                                    (object)name,
                                    (object)_minFileSize,
                                    (object)_maxFileSize,
                                });
    }
}
```
