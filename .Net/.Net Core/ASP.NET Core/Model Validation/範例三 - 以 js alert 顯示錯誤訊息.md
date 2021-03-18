# 範例三 - 以 js alert 顯示錯誤訊息

-   搭配 MemoryCache 減少反射作業時間
-   先將 ModelValidationState.Invalid 的欄位抓出來後，再轉成 string
-   理論上，支援無限階層

[Sample Code](https://github.com/ragnakuei/ModelStateToDtoAndToString)

### Controller

```csharp
public class TestController : Controller
{
    private readonly IModelStateErrorMessageGrouperService _modelStateErrorMessageGrouperService;

    private readonly IValidateFailMessageGeneratorService _validateFailMessageGeneratorService;

    public TestController(IModelStateErrorMessageGrouperService modelStateErrorMessageGrouperService,
                            IValidateFailMessageGeneratorService  validateFailMessageGeneratorService)
    {
        _modelStateErrorMessageGrouperService = modelStateErrorMessageGrouperService;
        _validateFailMessageGeneratorService  = validateFailMessageGeneratorService;
    }

    [HttpGet]
    public IActionResult Index()
    {
        return View();
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Index(TestDto dto)
    {
        if (ModelState.IsValid == false)
        {
            var invaliModelStateDto = _modelStateErrorMessageGrouperService.GroupBy(dto.GetType(), ModelState);
            var errorMessage        = _validateFailMessageGeneratorService.Generate(invaliModelStateDto);
            TempData["ValidMessage"] = errorMessage;
            return View(dto);
        }

        TempData["ValidMessage"] = "驗証成功";
        return RedirectToAction("Index");
    }
}
```

### TestDto

```csharp
public class TestDto
{
    [Display(Name             = "編號")]
    [Required(ErrorMessage    = "沒填是要怎麼抓資料")]
    [Range(1, 5, ErrorMessage = "{0} 數值 要介於 {1} 及 {2} 之間")]
    public int? Id { get; set; }

    [Display(Name = "名稱")]
    [DataType(DataType.Text)]
    [Required(ErrorMessage         = "請輸入{0}")]
    [StringLength(5, MinimumLength = 2, ErrorMessage = "{0} 長度 要介於 {2} 及 {1} 之間")]
    public string Name { get; set; }

    [Display(Name = "電子信箱")]
    [DataType(DataType.EmailAddress)]
    [Required(ErrorMessage     = "必填喔")]
    [EmailAddress(ErrorMessage = "為何不填 Email 格式")]
    public string Email { get; set; }
}
```

### View

```csharp
@model WebApplication2.Controllers.TestDto
@{
    ViewData["Title"] = "Test Page";
}

<h1>Test</h1>

<form method="post" enctype="multipart/form-data">
    <p>
        <label asp-for="Id"></label>
        <input asp-for="Id" />
    </p>
    <p>
        <label asp-for="Name"></label>
        <input asp-for="Name" />
    </p>
    <p>
        <label asp-for="Email"></label>
        <input asp-for="Email" />
    </p>
    <p>
        <input type="submit"
               value="Submit" />
    </p>
</form>

@section Scripts {
    <script>
        window.ValidMessage = `@(Html.Raw(TempData["ValidMessage"]?.ToString()))`;
        if(ValidMessage.length > 0)
        {
            alert(ValidMessage);
        }
    </script>
}
```

### Startup.ConfigureServices()

```csharp
services.AddScoped<IModelStateErrorMessageGrouperService, ModelStateErrorMessageGrouperService>();
services.AddScoped<IValidateFailMessageGeneratorService, ValidateFailMessageGeneratorService>();
services.AddScoped<IPropertyInfoService, PropertyInfoService>();
```

### IModelStateErrorMessageGrouperService

```csharp
public interface IModelStateErrorMessageGrouperService
{
    ModelStateErrorMessageDto GroupBy(Type type, ModelStateDictionary modelState);
}

public class ModelStateErrorMessageGrouperService : IModelStateErrorMessageGrouperService
{
    private readonly IPropertyInfoService _propertyInfoService;

    public ModelStateErrorMessageGrouperService(IPropertyInfoService propertyInfoService)
    {
        _propertyInfoService = propertyInfoService;
    }

    public ModelStateErrorMessageDto GroupBy(Type type, ModelStateDictionary modelState)
    {
        var result = new ModelStateErrorMessageDto();

        AssignForObject(result,
                        type,
                        modelState.Where(m => m.Value.ValidationState == ModelValidationState.Invalid)
                                    .Select(m => m));

        return result;
    }

    private void AssignForObject(ModelStateErrorMessageDto result, Type dataType, IEnumerable<KeyValuePair<string, ModelStateEntry>> modelState)
    {
        var propertyInfos = _propertyInfoService.GetDisplayNameProperties(dataType);

        foreach (var modelStateKv in modelState)
        {
            var splitKeyDto = SplitForFirstDotAndIndex(modelStateKv.Key);

            var propertyInfo = propertyInfos.GetValueOrDefault(splitKeyDto.PropertyName);

            if (propertyInfo == null)
            {
                // Custom Errors
                result.AddNormalProperty(splitKeyDto.PropertyName, modelStateKv.Value.Errors);
            }
            else if (propertyInfo.IsCollection)
            {
                var collectionObjectModelStateErrorMessageDto = result.GetCollectionObject(propertyInfo.DisplayAttributeName, splitKeyDto.Index);

                var collectionObjectKv = new KeyValuePair<string, ModelStateEntry>(splitKeyDto.OtherPropertyName, modelStateKv.Value);

                AssignForCollection(collectionObjectModelStateErrorMessageDto,
                                    propertyInfo.ElementType,
                                    new[] { collectionObjectKv });
            }
            else if (propertyInfo.IsClassObject)
            {
                var classObjectModelStateErrorMessageDto = result.GetClassObject(propertyInfo.DisplayAttributeName);

                var classObjectKv = new KeyValuePair<string, ModelStateEntry>(splitKeyDto.OtherPropertyName, modelStateKv.Value);

                AssignForObject(classObjectModelStateErrorMessageDto,
                                propertyInfo.ObjectType,
                                new[] { classObjectKv });
            }
            else
            {
                result.AddNormalProperty(propertyInfo.DisplayAttributeName, modelStateKv.Value.Errors);
            }
        }
    }

    private void AssignForCollection(ModelStateErrorMessageDto result, Type dataType, KeyValuePair<string, ModelStateEntry>[] modelState)
    {
        AssignForObject(result,
                        dataType,
                        modelState);
    }

    /// <summary>
    /// <para> 將 Id                   拆成  SplitKeyDto(-1, "Id",    string.Empty) </para>
    /// <para> 將 DtoA.Id              拆成  SplitKeyDto(-1, "DtoA",  "Id") </para>
    /// <para> 將 DtoAs[2].Id          拆成  SplitKeyDto( 2, "DtoAs", "Id") </para>
    /// <para> 將 DtoA.DtoBs[2].Id     拆成  SplitKeyDto(-1, "DtoA",  "DtoBs[2].Id") </para>
    /// <para> 將 DtoAs[1].DtoBs[2].Id 拆成  SplitKeyDto( 1, "DtoAs", "DtoBs[2].Id") </para>
    /// </summary>
    private SplitKeyDto SplitForFirstDotAndIndex(string key)
    {
        if (key.Contains('.') == false)
        {
            // Normal Property
            return new SplitKeyDto(-1, key, string.Empty);
        }

        var firstDotIndex = key.IndexOf('.');

        var firstPart = key.Substring(0, firstDotIndex);

        if (firstPart.Contains('['))
        {
            // collection
            var collectionPropertyParts = firstPart.Split('[');
            var collectionPropertyName  = collectionPropertyParts[0];

            var index = Int32.Parse(collectionPropertyParts[1].TrimEnd(']'));

            return new SplitKeyDto(index, collectionPropertyName, key.Substring(firstDotIndex + 1));
        }
        else
        {
            // class object
            return new SplitKeyDto(-1, firstPart, key.Substring(firstDotIndex + 1));
        }
    }

    private class SplitKeyDto
    {
        public int Index { get; }

        public string PropertyName { get; }

        public string OtherPropertyName { get; }

        public SplitKeyDto(int index, string propertyName, string otherPropertyName)
        {
            Index = index;

            PropertyName = propertyName;

            OtherPropertyName = otherPropertyName;
        }
    }
}
```

### IValidateFailMessageGeneratorService

```csharp
public interface IValidateFailMessageGeneratorService
{
    string Generate(ModelStateErrorMessageDto dto);
}

/// <summary>
/// 從 ModelStateDictionary 產生 Js alert 需要的 string
/// <remarks> 考量到 Property 要 Group By 不好處理，所以不做各欄位的名稱顯示 </remarks>
/// </summary>
public class ValidateFailMessageGeneratorService : IValidateFailMessageGeneratorService
{
    private readonly ResultStringBuilder _sb;

    private int _indentLevel;

    public ValidateFailMessageGeneratorService()
    {
        _sb = new ResultStringBuilder();

        _indentLevel = 0;
    }

    /// <summary>
    ///     將驗証失敗的資料轉成 string，讓前端的 alert 來顯示
    /// </summary>
    public string Generate(ModelStateErrorMessageDto dto)
    {
        _sb.AppendLine(_indentLevel, "欄位驗証失敗");
        _sb.AppendLine(_indentLevel, "--------------------------------------");

        AppendClassObjectDto(dto);

        return _sb.Result;
    }

    private void AppendClassObjectDto(ModelStateErrorMessageDto dto)
    {
        AppendNormalPropertiesLines(dto);

        if (dto.ClassObjectProperties.Count > 0)
        {
            // class object

            foreach (var classObjectProperty in dto.ClassObjectProperties)
            {
                _sb.AppendLine(_indentLevel, classObjectProperty.Key);

                _indentLevel++;

                AppendClassObjectDto(classObjectProperty.Value);

                _indentLevel--;
            }
        }

        if (dto.CollectionProperties.Count > 0)
        {
            // collection

            foreach (var collectionProperty in dto.CollectionProperties)
            {
                _sb.AppendLine(_indentLevel, collectionProperty.Key);

                _indentLevel++;

                foreach (var collectionElementProperty in collectionProperty.Value)
                {
                    _sb.AppendLine(_indentLevel, $"第 {collectionElementProperty.Key + 1} 個項目");

                    _indentLevel++;

                    AppendClassObjectDto(collectionElementProperty.Value);

                    _indentLevel--;
                }

                _indentLevel--;
            }
        }
    }

    private void AppendNormalPropertiesLines(ModelStateErrorMessageDto dto)
    {
        foreach (var normalProperty in dto.NormalProperties)
        {
            _sb.AppendLine(_indentLevel, normalProperty.Key);

            _indentLevel++;

            foreach (var error in normalProperty.Value)
            {
                _sb.AppendLine(_indentLevel, error);
            }

            _indentLevel--;
        }
    }

    #region ResultStringBuilder

    private class ResultStringBuilder
    {
        private StringBuilder _result = new StringBuilder();

        public string Result => _result.ToString();

        public void AppendLine(int indentLevel, string appendString)
        {
            var appendFullString = GetFullString(indentLevel, appendString);
            _result.AppendLine(appendFullString);
        }

        private string GetFullString(in int _indentLevel, string appendString)
        {
            return string.Join("", Enumerable.Repeat("- ", _indentLevel)) + appendString;
        }
    }

    #endregion
}
```

### IPropertyInfoService

```csharp
public interface IPropertyInfoService
{
    Dictionary<string, PropertyInfoDto> GetProperties(Type type);

    Dictionary<string, PropertyInfoDto> GetDisplayNameProperties(Type type);
}

public class PropertyInfoService : IPropertyInfoService
{
    private readonly IMemoryCache _memoryCache;

    public PropertyInfoService(IMemoryCache memoryCache)
    {
        _memoryCache = memoryCache;
    }

    public Dictionary<string, PropertyInfoDto> GetProperties(Type type)
    {
        return GetPropertiesWithAction(type, dto => true);
    }

    public Dictionary<string, PropertyInfoDto> GetDisplayNameProperties(Type type)
    {
        return GetPropertiesWithAction(type, dto => dto.DisplayAttribute != null);
    }

    private Dictionary<string, PropertyInfoDto> GetPropertiesWithAction(Type type, Func<PropertyInfoDto, bool> whereAction)
    {
        var cacheKey = GetCacheKey(type);

        var result = _memoryCache.Get<Dictionary<string, PropertyInfoDto>>(cacheKey);

        if (result != null)
        {
            return result;
        }

        result = type.GetProperties()
                        .Select(p =>
                                {
                                    var dto = new PropertyInfoDto();
                                    dto.PropertyName     = p.Name;
                                    dto.DisplayAttribute = p.GetCustomAttributes(typeof(DisplayAttribute), false)?.FirstOrDefault() as DisplayAttribute;
                                    dto.PropertyInfo     = p;
                                    dto.ElementType = new[]
                                                    {
                                                        p.PropertyType.GetElementType(),
                                                        p.PropertyType.GetGenericArguments().FirstOrDefault(gt => gt.IsValueType == false)
                                                    }.FirstOrDefault(t => t != null);

                                    dto.IsClassObject = dto.IsCollection                          == false
                                                    && dto.PropertyInfo.PropertyType.IsValueType == false
                                                    && dto.PropertyInfo.PropertyType             != typeof(string);

                                    if (dto.IsClassObject)
                                    {
                                        dto.ObjectType = dto.PropertyInfo.PropertyType;
                                    }

                                    return dto;
                                })
                        .Where(whereAction)
                        .ToDictionary(k => k.PropertyName,
                                    v => v);

        _memoryCache.Set(cacheKey, result);

        return result;
    }

    private static string GetCacheKey(Type type)
    {
        return $"PropertyInfo_{type?.Name}";
    }
}


public class PropertyInfoDto
{
    public string PropertyName { get; set; }

    public DisplayAttribute DisplayAttribute { get; set; }

    public string DisplayAttributeName
    {
        get
        {
            if (string.IsNullOrWhiteSpace(DisplayAttribute?.Name))
            {
                return PropertyName;
            }

            return DisplayAttribute.Name;
        }
    }

    public PropertyInfo PropertyInfo { get; set; }

    public bool IsCollection => ElementType != null;

    /// <summary>
    /// 用於 IsCollection = true 時，取出 IEnumerable of T 的 typeof(T)
    /// </summary>
    public Type ElementType { get; set; }

    public bool IsClassObject { get; set; }

    /// <summary>
    /// 用於 IsObject = true 時，取出 Object 的 Type
    /// </summary>
    public Type ObjectType { get; set; }
}
```

### ModelStateErrorMessageDto

```csharp
public class ModelStateErrorMessageDto
{
    /// <summary>
    /// Key: Property Display Name
    /// </summary>
    public Dictionary<string, List<string>> NormalProperties { get; set; }

    /// <summary>
    /// Key: Property Display Name
    /// Value:
    ///     Key: index: collection index
    ///     Value: dto
    /// </summary>
    public Dictionary<string, Dictionary<int, ModelStateErrorMessageDto>> CollectionProperties { get; set; }

    /// <summary>
    /// Key: Property Display Name
    /// </summary>
    public Dictionary<string, ModelStateErrorMessageDto> ClassObjectProperties { get; set; }

    public ModelStateErrorMessageDto()
    {
        NormalProperties = new Dictionary<string, List<string>>();

        CollectionProperties = new Dictionary<string, Dictionary<int, ModelStateErrorMessageDto>>();

        ClassObjectProperties = new Dictionary<string, ModelStateErrorMessageDto>();
    }

    public void AddNormalProperty(string keyName, ModelErrorCollection errors)
    {
        var keyPropertyErrors = NormalProperties.GetValueOrDefault(keyName);

        if (keyPropertyErrors?.Count > 0 == false)
        {
            keyPropertyErrors = new List<string>();
            NormalProperties.Add(keyName, keyPropertyErrors);
        }

        keyPropertyErrors.AddRange(errors.Select(e => e.ErrorMessage));
    }

    public ModelStateErrorMessageDto GetClassObject(string classObjectDisplayName)
    {
        if (ClassObjectProperties.TryGetValue(classObjectDisplayName, out var value))
        {
            return value;
        }
        else
        {
            var newValue = new ModelStateErrorMessageDto();
            ClassObjectProperties.Add(classObjectDisplayName, newValue);
            return newValue;
        }
    }

    public ModelStateErrorMessageDto GetCollectionObject(string collectionDisplayName, int? index)
    {
        if (CollectionProperties.TryGetValue(collectionDisplayName, out var collectionValues))
        {
            if (collectionValues.TryGetValue(index.GetValueOrDefault(), out var collectionValue))
            {
                return collectionValue;
            }

            var collectionNewValue = new ModelStateErrorMessageDto();
            collectionValues.Add(index.GetValueOrDefault(), collectionNewValue);
            return collectionNewValue;
        }
        else
        {
            var newCollectionDto = new ModelStateErrorMessageDto();
            var newCollectionWithIndex = new Dictionary<int, ModelStateErrorMessageDto>
                                            {
                                                [index.GetValueOrDefault()] = newCollectionDto,
                                            };

            CollectionProperties.Add(collectionDisplayName, newCollectionWithIndex);
            return newCollectionDto;
        }
    }
}
```
