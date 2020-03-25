# 將 Canvas 轉成 Bitmap 檔

給定 Canvas 後，再給定 filename 的絕對路徑，就可以轉成 bitmap

```csharp
public void ConvertCanvasToBitmap(Canvas canvas, string filename)
{

    RenderTargetBitmap renderBitmap = new RenderTargetBitmap((int)canvas.Width,
                                                                (int)canvas.Height,
                                                                96d,
                                                                96d,
                                                                PixelFormats.Pbgra32);

    //RenderTargetBitmap renderBitmap = new RenderTargetBitmap(1800, 200,96d, 96d, PixelFormats.Pbgra32);

    // needed otherwise the image output is black
    canvas.Measure(new Size((int)canvas.Width, (int)canvas.Height));
    canvas.Arrange(new Rect(new Size((int)canvas.Width, (int)canvas.Height)));

    renderBitmap.Render(canvas);

    //JpegBitmapEncoder encoder = new JpegBitmapEncoder();

    // for png bitmap
    PngBitmapEncoder encoder = new PngBitmapEncoder();

    encoder.Frames.Add(BitmapFrame.Create(renderBitmap));

    using (FileStream fs = File.Create(filename))
    {
        encoder.Save(fs);
    }
}
```