# 將 Canvas 轉成 ImageSource (BitmapImage)

```csharp
public BitmapImage ConvertCanvasToBitmap(Canvas canvas)
{

    double w = canvas.Width;
    double h = canvas.Height;
    double dpi = 300;                 // 可自訂清析度
    double scale = dpi / 96;

    RenderTargetBitmap renderBitmap = new RenderTargetBitmap((int)(w * scale),
                                                                (int)(h * scale),
                                                                dpi,
                                                                dpi,
                                                                PixelFormats.Pbgra32);

    //RenderTargetBitmap renderBitmap = new RenderTargetBitmap(1800, 200,96d, 96d, PixelFormats.Pbgra32);

    // needed otherwise the image output is black
    canvas.Measure(new Size((int)canvas.Width, (int)canvas.Height));
    canvas.Arrange(new Rect(new Size((int)canvas.Width, (int)canvas.Height)));

    renderBitmap.Render(canvas);

    //JpegBitmapEncoder encoder = new JpegBitmapEncoder();

    // for png bitmap
    PngBitmapEncoder encoder = new PngBitmapEncoder();


    // using (FileStream fs = File.Create(filename))
    // {
    //     encoder.Save(fs);
    // }
    
    MemoryStream memoryStream = new MemoryStream();
    BitmapImage image = new BitmapImage();

    encoder.Frames.Add(BitmapFrame.Create(renderBitmap));
    encoder.Save(memoryStream);
    memoryStream.Position = 0;
    image.BeginInit();
    image.StreamSource = memoryStream;
    image.EndInit();
    image.Freeze();

    return image;
}
```
