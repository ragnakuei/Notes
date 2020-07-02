# Ellipse

## 以 Code 設定 [Tooltip](https://docs.microsoft.com/en-us/dotnet/api/system.windows.controls.tooltipservice.showduration)

```csharp
Ellipse pin = new Ellipse
                {
                    Width           = _pinRadiusInPixel,
                    Height          = _pinRadiusInPixel,
                    Fill            = new SolidColorBrush(Colors.White),
                    StrokeThickness = 1,
                    Stroke          = new SolidColorBrush(TopView2dColor.Stroke),

                    // change to Cartesian Coordinate System
                    RenderTransform = new TranslateTransform((_initialDistanceHorizon + pinPositionX                                         - _pinRadius * 0.5) * _pixelLengthScalarFor2d,
                                                            (_chipInfo.Ysize - (_initialDistanceVertical + pinPositionY - _pinRadius * 0.5) - _pinRadius)       * _pixelLengthScalarFor2d),

                    ToolTip = $"{pinInfo.BlockPosition.Alpha}{pinInfo.BlockPosition.Number} {pinInfo.Text}",
                };

ToolTipService.SetShowDuration(pin, 10000);
ToolTipService.SetInitialShowDelay(pin, 0);
ToolTipService.SetBetweenShowDelay(pin, 0);
```
