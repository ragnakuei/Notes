# Canvas

- 抓相對路徑的方式

```csharp
var targetPosition = rect.TranslatePoint(new Point(0, 0), cav_board);
lbChipX.Content = targetPosition.X;
lbChipY.Content = targetPosition.Y;
```