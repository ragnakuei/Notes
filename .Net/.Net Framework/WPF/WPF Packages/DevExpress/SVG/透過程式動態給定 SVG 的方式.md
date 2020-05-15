# 透過程式動態給定 SVG 的方式

```xml
<Canvas Name="rootLayout">
    <Image Source="{dx:SvgImageSource Uri=/Images/Notebook 1.svg}" Width="32"  />
</Canvas>
```

```csharp
public DView()
{
    InitializeComponent();
    var svgFilePath = Path.Combine(
                                    System.AppDomain.CurrentDomain.BaseDirectory,
                                    "Images",
                                    "NoteBook 3.svg"
                                    );
    AddSveImage(svgFilePath);
}

private void AddSveImage(string svgFilePath)
{
    var image = new Image
                {
                    Width = 32,
                    Source = SvgHelper.FromFilePathToImageSource(svgFilePath),
                    Margin = new Thickness
                                {
                                    Left = 100,
                                    Top = 100
                                }
                };
    rootLayout.Children.Add(image);
}

public static class SvgHelper
{
    public static ImageSource FromFilePathToImageSource(string svgFilePath)
    {
        var svgStream = File.Open(svgFilePath, FileMode.Open);
        var svgImage = SvgLoader.LoadFromStream(svgStream);
        var size = new Size(svgImage.Width * ScreenHelper.ScaleX, svgImage.Height * ScreenHelper.ScaleX);
        return WpfSvgRenderer.CreateImageSource(svgImage, size, null, null, true);
    }
}
```