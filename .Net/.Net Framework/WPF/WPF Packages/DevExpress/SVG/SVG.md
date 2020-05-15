# SVG

只顯示 SVG 的可用資料類型

- DXImage
- Image

---

## 範例

```csharp
SvgImage image = SvgImage.FromFile(@"D:\Work\Images\_SVG\Driving.svg");
//load from Resources 
//image file's "Build Action" must be set to "Embedded Resource" 
SvgImage image = SvgImage.FromResources("DXApplication1.Resources.Driving.svg", typeof(Form2).Assembly);
simpleButton1.ImageOptions.SvgImage = image;
```

[參考資料](https://documentation.devexpress.com/WindowsForms/117631/Common-Features/Graphics-Performance-and-High-DPI/How-To-Draw-and-Use-SVG-Images)