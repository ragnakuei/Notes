# LineStyle

## DashCap

適用於 DashesSerialize 或 DashStyle 有給定時

[PenLineCap](https://docs.microsoft.com/en-us/dotnet/api/system.windows.media.penlinecap)

## DashesSerialize

Offset 要搭配 `OffsetSerialize`

給定 List\<double>

如果給定二個數字

-   index = 0 - 畫線部份
-   index = 1 - 空白部份

給定三個數字，目前不確定規則如何

## OffsetSerialize

與 DashesSerialize 搭配的 offset

## DashStyle

-   比 DashesSerialize 更有彈性調整 dash 的樣式

-   以 DoubleCollection 所給定的內容來劃線

-   properties
    -   Dashes
    -   Offset

### Dashes

    如果給定二個數字

    標準的 dash 要給定 new DoubleCollection(new[] { 1.0, 2.0 })

## LineJoin

線的角落要如何顯示

[PenLineJoin](https://docs.microsoft.com/en-us/dotnet/api/system.windows.media.penlinejoin)

|                   | 說明            |
| ----------------- | --------------- |
| PenLineJoin.Miter | 無修飾 (預設值) |
| PenLineJoin.Bevel | 削平            |
| PenLineJoin.Round | 圓角            |

## MiterLimit

## 各種簡單的 line style 範例

```csharp
public class LineStyleTypeParameter
{
    public const string SolidLine    = "Solid Line";
    public const string Dot          = "Dot";
    public const string DotDot       = "Dot Dot";
    public const string ShortDash    = "Short Dash";
    public const string ShortDotDash = "Short Dot Dash";
    public const string LongDash     = "Long Dash";
    public const string LongDotDash  = "Long Dot Dash";

    public static string[] Parameters = new[]
                                        {
                                            SolidLine,
                                            Dot,
                                            DotDot,
                                            ShortDash,
                                            ShortDotDash,
                                            LongDash,
                                            LongDotDash,
                                        };
}

public class LineStyleService
{
    public LineStyle Generate(int thickness, string lineStyleTypeParameter)
    {
        var result = new LineStyle
                        {
                            DashCap   = PenLineCap.Round,
                            LineJoin  = PenLineJoin.Round,
                            Thickness = thickness,
                        };

        switch (lineStyleTypeParameter)
        {
            case LineStyleTypeParameter.Dot:
                ApplyDot(result);
                break;
            case LineStyleTypeParameter.DotDot:
                ApplyDotDot(result);
                break;
            case LineStyleTypeParameter.ShortDash:
                ApplyShortDash(result);
                break;
            case LineStyleTypeParameter.ShortDotDash:
                ApplyShortDotDash(result);
                break;
            case LineStyleTypeParameter.LongDash:
                ApplyLongDash(result);
                break;
            case LineStyleTypeParameter.LongDotDash:
                ApplyLongDotDash(result);
                break;
            case LineStyleTypeParameter.SolidLine:
            default:
                break;
        }

        return result;
    }

    private void ApplyDot(LineStyle lineStyle)
    {
        lineStyle.DashesSerialize = new List<double> { 0.0, 1.5 };
        lineStyle.OffsetSerialize = 1;
    }

    private void ApplyDotDot(LineStyle lineStyle)
    {
        lineStyle.DashStyle = new DashStyle
                                {
                                    // 1st dot, 1st dot-interval 2nd dot, 2nd dot, 2nd dot-interval
                                    Dashes = new DoubleCollection(new[] { 0.0, 1.2, 0.0, 2 }),
                                    Offset = 1,
                                };
    }

    private void ApplyShortDash(LineStyle lineStyle)
    {
        lineStyle.DashesSerialize = new List<double> { 1.0, 1.5 };
    }

    private void ApplyShortDotDash(LineStyle lineStyle)
    {
        lineStyle.DashStyle = new DashStyle
                                {
                                    Dashes = new DoubleCollection(new[] { 0.0, 1.2, 1.0, 2 }),
                                    Offset = 1,
                                };
    }

    private void ApplyLongDash(LineStyle lineStyle)
    {
        lineStyle.DashesSerialize = new List<double> { 2.0, 1.5 };
    }

    private void ApplyLongDotDash(LineStyle lineStyle)
    {
        lineStyle.DashStyle = new DashStyle
                                {
                                    Dashes = new DoubleCollection(new[] { 0.0, 1.2, 2.0, 2 }),
                                    Offset = 1,
                                };
    }
}
```
