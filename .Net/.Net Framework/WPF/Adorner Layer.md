# [Adorner Layer](https://docs.microsoft.com/zh-tw/dotnet/framework/wpf/controls/adorners-overview)

可用來對某個指定的 UIElement 加上外觀

https://www.nbdtech.com/Blog/archive/2010/06/21/wpf-adorners-part-1-ndash-what-are-adorners.aspx

## 應用情境

### 拖接時，把 source 物件加上效果

```csharp
private void PreviewMouseMove(object sender, MouseEventArgs e)
{
    if (e.LeftButton == MouseButtonState.Pressed)
    {
        Point currentPosition = e.GetPosition((UIElement)e.Source);

        if ((Math.Abs(currentPosition.X - _lastMouseDown.X) > 5.0) ||
            (Math.Abs(currentPosition.Y - _lastMouseDown.Y) > 5.0))
        {
            if (_draggedItem != null)
            {
                var dragChip = new DragChip
                {
                    Name = _draggedItem.Header
                };

                var myAdornerLayer = AdornerLayer.GetAdornerLayer(_draggedItem);
                myAdornerLayer.Add(new SimpleCircleAdorner(_draggedItem));

                DragDropEffects finalDropEffect = DragDrop.DoDragDrop((UIElement)e.Source, dragChip, DragDropEffects.Move);
            }
        }
    }
}

public class SimpleCircleAdorner : Adorner
{
    // Be sure to call the base class constructor.
    public SimpleCircleAdorner(UIElement adornedElement)
        : base(adornedElement)
    {
    }

    // A common way to implement an adorner's rendering behavior is to override the OnRender
    // method, which is called by the layout system as part of a rendering pass.
    protected override void OnRender(DrawingContext drawingContext)
    {
        Rect adornedElementRect = new Rect(this.AdornedElement.DesiredSize);

        // Some arbitrary drawing implements.
        SolidColorBrush renderBrush = new SolidColorBrush(Colors.Green);
        renderBrush.Opacity = 0.2;
        Pen renderPen = new Pen(new SolidColorBrush(Colors.Navy), 1.5);
        double renderRadius = 5.0;

        // Draw a circle at each corner.
        drawingContext.DrawEllipse(renderBrush, renderPen, adornedElementRect.TopLeft, renderRadius, renderRadius);
        drawingContext.DrawEllipse(renderBrush, renderPen, adornedElementRect.TopRight, renderRadius, renderRadius);
        drawingContext.DrawEllipse(renderBrush, renderPen, adornedElementRect.BottomLeft, renderRadius, renderRadius);
        drawingContext.DrawEllipse(renderBrush, renderPen, adornedElementRect.BottomRight, renderRadius, renderRadius);
    }
}
```

