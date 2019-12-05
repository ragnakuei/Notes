# License 註冊方式

AposeLicenseService.cs

```csharp
public class AposeLicenseService
{
    public static void RegisterPdf()
    {
        string licenseFilePath = GetLicenseFilePath();
        new Aspose.Pdf.License().SetLicense(licenseFilePath);
    }

    public static void RegisterWords()
    {
        string licenseFilePath = GetLicenseFilePath();
        new Aspose.Words.License().SetLicense(licenseFilePath);
    }

    private static string GetLicenseFilePath()
    {
        var licenseFile = ConfigurationManager.AppSettings["AsposeLicenseFileName"];
        var licenseFileDirectoryPath = AppDomain.CurrentDomain.BaseDirectory;
        var licenseFilePath = Path.Combine(licenseFileDirectoryPath, licenseFile);
        return licenseFilePath;
    }
}
```

組態檔

```xml
<configuration>
  <appSettings>
    <add key="AsposeLicenseFileName" value="Aspose.Total.lic"/>
  </appSettings>
</configuration>
```
